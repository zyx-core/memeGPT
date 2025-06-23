import 'package:flutter/material.dart';
import 'package:meme_gpt/screens/home_screen.dart';

void main() {
  runApp(const MemeGPTApp());
}

class MemeGPTApp extends StatelessWidget {
  const MemeGPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemeGPT',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}