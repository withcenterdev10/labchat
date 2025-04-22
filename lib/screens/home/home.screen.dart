import 'package:easy_locale/easy_locale.dart';
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
  void initState() {
    super.initState();

    lo.set(key: 'Chat', locale: 'en', value: 'Chat');
    lo.set(key: 'Chat', locale: 'ko', value: '채팅');

    lo.set(key: 'Lab Chat', locale: 'en', value: 'Lab Chat');
    lo.set(key: 'Lab Chat', locale: 'ko', value: '실험실 채');

    lo.set(key: 'Sign Out', locale: 'en', value: 'Sign Out');
    lo.set(key: 'Sign Out', locale: 'ko', value: '로그아웃');

    lo.set(key: 'Send', locale: 'en', value: 'Send');
    lo.set(key: 'Send', locale: 'ko', value: '보내다');

    lo.set(key: 'Type a message', locale: 'en', value: 'Type a message');
    lo.set(key: 'Type a message', locale: 'ko', value: '메시지를 입력하세요');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Lab Chat".t),
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

            Text('Home'.t),

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
