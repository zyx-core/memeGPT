import 'package:flutter/material.dart';
import 'package:meme_gpt/screens/generate_screen.dart'; // Import the actual GenerateScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemeGPT'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print('👉 Button Pressed');

            // ✅ Push the real GenerateScreen page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  GenerateScreen(),
              ),
            );
          },
          child: const Text('Generate Meme'),
        ),
      ),
    );
  }
}
