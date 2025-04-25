import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_locale/easy_locale.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

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
                final isCurrentUser =
                    data['sender_uid'] ==
                    FirebaseAuth.instance.currentUser!.uid;
                return Align(
                  alignment:
                      isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isCurrentUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (data['image_url'] != null)
                            ? Image.network(
                              data['image_url'],
                              width: 100,
                              height: 100,
                            )
                            : SizedBox(),

                        Text(data['text'], style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                            data['created_at'],
                          ).toString(),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
              //   return ListTile(
              //     title: Text(data['text']),
              //     subtitle: Text(
              //       data['sender_uid'],
              //       style: TextStyle(color: Colors.blue, fontSize: 18),
              //     ),
              //     trailing: Text(
              //       DateTime.fromMillisecondsSinceEpoch(
              //         data['created_at'],
              //       ).toString(),
              //     ),
              //   );
              // },
            ),
          ),

          SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => pickImage(),
                  icon: Icon(Icons.camera_alt),
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type a message'.t,
                    ),
                    onSubmitted: (v) => sendMessage(v),
                  ),
                ),

                ElevatedButton(onPressed: sendMessage, child: Text('Send'.t)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessage([String? v, File? imageFile]) async {
    final text = textController.text.trim();
    String? imageUrl;

    if (text.isEmpty && imageFile == null) return;

    if (imageFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref('lab-chat/$roomId')
          .child(DateTime.now().toIso8601String());

      await storageRef.putFile(imageFile);

      imageUrl = await storageRef.getDownloadURL();
      print("Succesfully uploaded -----> $imageUrl");
    }
    print("before checking the");

    print("After");
    textController.clear();
    await FirebaseDatabase.instance.ref('lab-chat/$roomId').push().set({
      'image_url': imageUrl,
      'text': text,
      'sender_uid': FirebaseAuth.instance.currentUser!.uid,
      'created_at': ServerValue.timestamp,
    });
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagePath = image.path;
    sendMessage(null, File(imagePath));
    print(imagePath);
  }
}
