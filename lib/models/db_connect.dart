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

      // 🔴 DEBUG (keep for now)
      print('RAW >>> ${body.replaceAll('\n', '\\n')}');

      // ✅ Regex: extract LAST JSON array safely
      final match = RegExp(r'\[[\s\S]*\]').allMatches(body).lastOrNull;

      if (match == null) {
        print('No JSON array found');
        return [];
      }

      final cleanJson = match.group(0)!;

      final List decoded = jsonDecode(cleanJson);

      return decoded
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Fetch questions error: $e');
      return [];
    }
  }
}
