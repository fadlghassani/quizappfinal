import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question_model.dart';

class DBconnect {
  static const String _url =
      'https://quizappfinal.onrender.com/get_questions.php';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: const {
          'Accept': 'application/json',
        },
      );

      // 🔹 Print the raw response for debugging
      print('Raw response: ${response.body}');

      // 🔹 Check if the server returned a successful status
      if (response.statusCode != 200) {
        print('Server returned error: ${response.statusCode}');
        return [];
      }

      final body = response.body.trim();

      // 🔹 Find the first '[' character to locate the questions array
      final startIndex = body.indexOf('[');
      if (startIndex == -1) {
        print('No question array found in response');
        return [];
      }

      // 🔹 Extract the JSON array string only
      final jsonArrayString = body.substring(startIndex);

      // 🔹 Decode the array into a dynamic list
      final List<dynamic> decoded = jsonDecode(jsonArrayString);

      // 🔹 Convert each JSON object into a Question instance
      return decoded
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // 🔹 Catch any errors to avoid crashing the app
      print('Fetch questions error: $e');
      return [];
    }
  }
}
