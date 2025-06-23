import 'package:flutter/material.dart';
import 'generate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF101010) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        elevation: 1,
        title: Text(
          'MemeGPT',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Unleash AI-Powered Meme Captions!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: isDarkMode ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? const Color(0xFF2E2E2E) : Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GenerateScreen(),
                  ),
                );
              },
              child: const Text(
                'Generate Meme',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
