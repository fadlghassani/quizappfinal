import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final Color color;
  final VoidCallback? onTap;
  final bool shadow;

  const OptionCard({
    Key? key,
    required this.option,
    required this.color,
    this.onTap,
    this.shadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: shadow
            ? [BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(2, 2))]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white, // White text for visibility
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
