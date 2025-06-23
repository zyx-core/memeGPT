import 'package:flutter/material.dart';

class MemeFullScreen extends StatelessWidget {
  final String caption;

  const MemeFullScreen({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
