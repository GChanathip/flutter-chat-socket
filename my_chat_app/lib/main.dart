import 'package:flutter/material.dart';
import 'package:my_chat_app/ui/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black45),
        scaffoldBackgroundColor: Colors.black45,
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}
