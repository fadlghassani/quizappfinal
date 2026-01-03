import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question_model.dart';

class DBconnect {
  static const String _url =
      'https://quizappfinal.onrender.com/get_questions.php';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http
          .get(Uri.parse(_url))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        return [];
      }

      final body = response.body;

      // 🔹 Debug output
      print('RAW >>> ${body.replaceAll('\n', '\\n')}');

      // 🔹 Find all JSON arrays in the response
      final matches = RegExp(r'\[[\s\S]*\]').allMatches(body);
      if (matches.isEmpty) {
        print('No JSON array found');
        return [];
      }

      // 🔹 Take the last array (most likely the questions)
      final cleanJson = matches.last.group(0)!;

      // 🔹 Decode into List
      final List decoded = jsonDecode(cleanJson);

      // 🔹 Convert into Question objects
      return decoded
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Fetch questions error: $e');
      return [];
    }
  }
}
