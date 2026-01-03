import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question_model.dart';

class DBconnect {
  static const String _url =
      'https://quizappfinal.onrender.com/get_questions.php';

  Future<List<Question>> fetchQuestions() async {
    try {
      final uri = Uri.parse(_url);

      final response = await http.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE BODY: ${response.body}');

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        return decoded.map<Question>((q) => Question.fromJson(q)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }
}
