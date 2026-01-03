import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E), // Dark dialog
      title: const Text('Quiz Finished', style: TextStyle(color: Colors.white)),
      content: Text(
        'You scored $result out of $questionLength',
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('Restart', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
