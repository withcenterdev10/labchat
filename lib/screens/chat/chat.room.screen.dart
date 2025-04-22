import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatRoom')),
      body: const Column(children: [Text("ChatRoom")]),
    );
  }
}
