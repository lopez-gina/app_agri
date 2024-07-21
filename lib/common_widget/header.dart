import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 232, 231, 231),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          // '${isSubmitted ? 'CORRECTION - ' : ''}Question1\nLabel the parts of a leaf${isSubmitted ? '\nCorrect answers: ${globals.globalScore}/${labelPositions.length}' : ''}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
