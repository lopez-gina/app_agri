import 'package:app_agri/simple_diagram_editor/widget/component/base_component_body.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

class RectBody extends StatelessWidget {
  final ComponentData componentData;

  const RectBody({
    super.key,
    required this.componentData,
  });

  @override
  Widget build(BuildContext context) {
    return BaseComponentBody(
      componentData: componentData,
      componentPainter: RectPainter(
        color: componentData.data.color,
        borderColor: componentData.data.borderColor,
        borderWidth: componentData.data.borderWidth,
      ),
    );
  }
}

class RectPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  Size componentSize = const Size(0, 0);

  RectPainter({
    this.color = Colors.grey,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    componentSize = size;

    Path path = componentPath();

    canvas.drawPath(path, paint);

    if (borderWidth > 0) {
      if (borderWidth > 0) {
        paint
          ..style = PaintingStyle.stroke
          ..color = borderColor
          ..strokeWidth = borderWidth;

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    Path path = componentPath();
    return path.contains(position);
  }

  Path componentPath() {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(componentSize.width, 0);
    path.lineTo(componentSize.width, componentSize.height);
    path.lineTo(0, componentSize.height);
    path.close();
    return path;
  }
}
