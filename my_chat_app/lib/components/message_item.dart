import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(
      {Key? key,
      required this.text,
      required this.sentByMe,
      required this.sentTime})
      : super(key: key);
  final String text;
  final bool sentByMe;
  final DateTime sentTime;

  @override
  Widget build(BuildContext context) {
    String time = '${sentTime.hour} ${sentTime.minute}';
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: sentByMe ? Colors.white : Colors.purple,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: sentByMe ? Colors.purple : Colors.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: sentByMe ? Colors.purple : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
