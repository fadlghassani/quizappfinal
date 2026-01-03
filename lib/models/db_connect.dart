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

      

      final body = response.body.trim();

     

      final List<dynamic> decoded = jsonDecode(body);

      return decoded
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // 🔴 DO NOT rethrow
      print('Fetch questions error: $e');
      return [];
    }
  }
}
