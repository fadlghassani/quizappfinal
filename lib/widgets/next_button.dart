import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF1E88E5), // Blue accent for visibility
      onPressed: onPressed,
      child: const Icon(Icons.navigate_next, color: Colors.white),
    );
  }
}
