import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_chat_app/components/message_item.dart';
import 'package:my_chat_app/controller/chat_controller.dart';
import 'package:my_chat_app/model/message.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgController = TextEditingController();
  late IO.Socket socket;

  ChatController chatController = ChatController();

  //TODO : change localhost to your current v4 ip
  String localhost = '192.168.1.35';

  void sendMessage(String text) {
    Message message = Message(
        message: text, senderId: socket.id ?? '', sentTime: DateTime.now());
    socket.emit('message', message.toJson());
    chatController.chatMessage.add(message);
  }

  void setUpSocketListener() {
    socket.on(
      "message-receive",
      (data) => {
        debugPrint(data.toString()),
        chatController.chatMessage.add(Message.formJson(data))
      },
    );
    socket.on(
      "connected-user",
      (data) {
        debugPrint(data.toString());
        chatController.connectedUser.value = data;
      },
    );
  }

  @override
  void initState() {
    socket = IO.io('http://$localhost:4000',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket.connect();
    setUpSocketListener();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket IO Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                child: Text(
                  "Conntect User ${chatController.connectedUser}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Obx(
              (() => ListView.builder(
                    itemCount: chatController.chatMessage.length,
                    itemBuilder: (context, index) {
                      var currentItem = chatController.chatMessage[index];
                      return MessageItem(
                        text: currentItem.message,
                        sentByMe: currentItem.senderId == socket.id,
                        sentTime: currentItem.sentTime,
                      );
                    },
                  )),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purpleAccent,
                controller: msgController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            sendMessage(msgController.text);
                            msgController.clear();
                          },
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
