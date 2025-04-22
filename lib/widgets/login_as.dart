import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labchat/screens/chat/chat.room.screen.dart';

class LoginAs extends StatelessWidget {
  final String name;

  const LoginAs(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                    email: '${name.toLowerCase()}@test.com',
                    password: '12345a,*',
                  );
              log("User signed in: ${userCredential.user?.uid}");
            } catch (e) {
              log("Error signing in: $e");
            }
          },
          child: Text(name),
        ),
        ElevatedButton(
          onPressed: () {
            context.push(ChatRoomScreen.routeName);
          },
          child: Text('Chat'),
        ),
      ],
    );
  }
}
