// lib/screens/meme_full_screen.dart
import 'package:flutter/material.dart';

class MemeFullScreen extends StatelessWidget {
  final String memeText;

  const MemeFullScreen({super.key, required this.memeText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              memeText,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
