import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  // ✅ Only the base API URL — no ?key here
  static const String _apiKey = 'AIzaSyBiTEw5d6MNmVyQU-YBDLSVycdOEE9SVd8';
  static const String _apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  static Future<String> generateMemeCaption(String topic) async {
    final prompt = "Generate a short, funny, and creative meme caption about: $topic";

    final response = await http.post(
      Uri.parse("$_apiUrl?key=$_apiKey"), // ✅ Only add ?key here
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'].trim();
    } else {
      return "Oops! Something went wrong with Gemini.";
    }
  }
}
