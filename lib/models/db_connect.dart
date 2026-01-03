import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question_model.dart';

class DBconnect {
  static const String _url =
      'https://quizappfinal.onrender.com/get_questions.php';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http
          .get(
            Uri.parse(_url),
            headers: const {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 20));

      print('Raw response: ${response.body}');

      if (response.statusCode != 200) {
        print('Server returned error: ${response.statusCode}');
        return [];
      }

      final body = response.body.trim();

      // 🔑 Extract ONLY the JSON array
      final startIndex = body.lastIndexOf('[');
      final endIndex = body.lastIndexOf(']');

      if (startIndex == -1 || endIndex == -1 || endIndex < startIndex) {
        print('No valid question array found');
        return [];
      }

      final jsonArrayString =
          body.substring(startIndex, endIndex + 1);

      final List decoded = jsonDecode(jsonArrayString);

      return decoded
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Fetch questions error: $e');
      return [];
    }
  }
}
