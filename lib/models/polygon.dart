import 'package:flutter/material.dart';

class Polygon {
  final List<Offset> vertices;

  Polygon(this.vertices);

  bool contains(Offset point) {
    bool result = false;
    for (int i = 0, j = vertices.length - 1; i < vertices.length; j = i++) {
      if ((vertices[i].dy > point.dy) != (vertices[j].dy > point.dy) &&
          (point.dx <
              (vertices[j].dx - vertices[i].dx) *
                      (point.dy - vertices[i].dy) /
                      (vertices[j].dy - vertices[i].dy) +
                  vertices[i].dx)) {
        result = !result;
      }
    }
    return result;
  }
}
