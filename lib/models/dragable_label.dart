import 'package:flutter/material.dart';

class DraggableLabel extends StatelessWidget {
  final String label;
  final bool isDragging;

  const DraggableLabel({
    required Key key,
    required this.label,
    this.isDragging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDragging ? Colors.lightGreenAccent : Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
    );
  }
}
