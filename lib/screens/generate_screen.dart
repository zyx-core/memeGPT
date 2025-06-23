import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/gemini_service.dart';
import 'meme_full_screen.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _captions = [];
  bool _loading = false;

  void _generateCaptions() async {
    FocusScope.of(context).unfocus(); // ✅ Dismiss keyboard

    final topic = _controller.text.trim();
    if (topic.isEmpty) return;

    setState(() => _loading = true);

    List<String> newCaptions = [];
    for (int i = 0; i < 3; i++) {
      final caption = await GeminiService.generateMemeCaption("$topic #${i + 1}");
      newCaptions.add(caption);
    }

    setState(() {
      _captions.insertAll(0, newCaptions);
      _loading = false;
    });
  }

  Future<void> _saveToFile(String text) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/meme_${DateTime.now().millisecondsSinceEpoch}.txt');
    await file.writeAsString(text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text(' MemeGPT'),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      labelText: 'Enter a topic',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _generateCaptions,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Generate Memes', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black26),
            if (_captions.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "Generate to begin!",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              )
            else
              SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _captions.length,
                  itemBuilder: (context, index) {
                    final caption = _captions[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MemeFullScreen(caption: caption),
                        ),
                      ),
                      child: Container(
                        width: 260,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(2, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  caption,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.save, color: Colors.grey),
                                  onPressed: () => _saveToFile(caption),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.grey),
                                  onPressed: () => Share.share(caption),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy, color: Colors.grey),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: caption));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Copied!')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
