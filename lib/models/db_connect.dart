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

      // ✅ IMPORTANT CHANGE IS HERE
      final startIndex = body.lastIndexOf('[');
      if (startIndex == -1) {
        print('No question array found in response');
        return [];
      }

      final jsonArrayString = body.substring(startIndex);

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
