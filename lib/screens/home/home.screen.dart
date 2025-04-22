import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labchat/widgets/login_as.dart';
import 'package:labchat/widgets/sign_out.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("LAB CHAT"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "Logged in as ${snapshot.data?.uid}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    "Not logged in",
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }
              },
            ),

            const Text('Login'),

            LoginAs('Apple'),
            LoginAs('Banana'),
            LoginAs('Cherry'),
            LoginAs('Durian'),
            SignOut(),
          ],
        ),
      ),
    );
  }
}
