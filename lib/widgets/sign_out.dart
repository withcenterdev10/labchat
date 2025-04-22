import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          log("User signed out");
        } catch (e) {
          log("Error signing out: $e");
        }
      },
      child: const Text('Sign Out'),
    );
  }
}
