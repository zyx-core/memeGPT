import 'package:flutter/material.dart';
import '../screens/meme_full_screen.dart';

class GenerateScreen extends StatelessWidget {
  final List<String> _captions = [
    "When you realize it's Monday again...",
    "Coding at 3 AM like a genius.",
    "Why fix bugs when you can sleep?",
    "Flutter devs be like: hot reload all day.",
    "That moment when it finally compiles!",
    "I don’t always test my code, but when I do, I do it in production.",
    "Waiting for Flutter build to finish like it's cooking biryani.",
    "Git commit -m 'final_final_FINAL_version_really_final.dart'",
  ];

  Color getRandomColor() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    colors.shuffle();
    return colors.first.withOpacity(0.85);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meme List'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _captions.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final caption = _captions[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MemeFullScreen(memeText: caption),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: getRandomColor(),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          );
        },
      ),
    );
  }
}
