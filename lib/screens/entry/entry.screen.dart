import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  static const String routeName = '/Entry';
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entry')),
      body: const Column(children: [Text("Entry")]),
    );
  }
}
