import 'package:flutter/material.dart';

class ScoreText extends StatelessWidget {
  final int score;

  const ScoreText({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        'Score: $score',
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
