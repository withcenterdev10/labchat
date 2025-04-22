import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  final String roomId;
  const ChatRoomScreen({super.key, required this.roomId});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  get roomId =>
      ([widget.roomId, FirebaseAuth.instance.currentUser!.uid]
        ..sort()).join('--');

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat With: ${widget.roomId}')),
      body: Column(
        children: [
          Expanded(
            child: FirebaseDatabaseListView(
              query: FirebaseDatabase.instance.ref('lab-chat/$roomId'),
              itemBuilder: (_, snapshot) {
                final data = snapshot.value as Map;
                return ListTile(
                  title: Text(data['text']),
                  subtitle: Text(
                    data['sender_uid'],
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  trailing: Text(
                    DateTime.fromMillisecondsSinceEpoch(
                      data['created_at'],
                    ).toString(),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type a message',
                    ),
                    onSubmitted: (v) => sendMessage(v),
                  ),
                ),

                ElevatedButton(onPressed: sendMessage, child: Text('Send')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage([String? v]) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    textController.clear();
    await FirebaseDatabase.instance.ref('lab-chat/$roomId').push().set({
      'text': text,
      'sender_uid': FirebaseAuth.instance.currentUser!.uid,
      'created_at': ServerValue.timestamp,
    });
  }
}
