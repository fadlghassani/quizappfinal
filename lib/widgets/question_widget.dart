import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final int indexAction;
  final String question;
  final int totalQuestions;

  const QuestionWidget({
    Key? key,
    required this.indexAction,
    required this.question,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Question ${indexAction + 1}/$totalQuestions',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
