import 'package:easy_design_system/easy_design_system.dart';
import 'package:easy_locale/easy_locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labchat/firebase_options.dart';
import 'package:labchat/router.dart';
import 'package:easy_design_system/easy_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize EasyLocale
  await LocaleService.instance.init(
    deviceLocale: false,
    defaultLocale: 'ko',
    fallbackLocale: 'en',
    useKeyAsDefaultText: true,
  );
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ComicThemeData.of(context),
      routerConfig: router,
    );
  }
}
