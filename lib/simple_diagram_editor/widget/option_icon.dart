import 'package:flutter/material.dart';

class OptionIcon extends StatelessWidget {
  final Color color;
  final double size;
  final BoxShape shape;
  final String tooltip;
  final IconData? iconData;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onPressed;

  const OptionIcon({
    super.key,
    this.color = Colors.white,
    this.size = 40,
    this.shape = BoxShape.rectangle,
    this.tooltip = '',
    this.iconData,
    this.iconColor = Colors.black,
    this.iconSize = 20,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: shape,
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        icon: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
