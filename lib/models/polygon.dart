import 'package:flutter/material.dart';

class Polygon {
  final List<Offset> vertices;
  Offset centroid;

  Polygon(
    this.vertices,
    this.centroid,
  );

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

  void scaleOffset(Size imageScaledSize) {
    Size imageOrignalSize = const Size(850, 823);
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = Offset(
          vertices[i].dx * imageScaledSize.height / imageOrignalSize.height,
          vertices[i].dy * imageScaledSize.width / imageOrignalSize.width);
    }
    centroid = Offset(
        centroid.dx * imageScaledSize.height / imageOrignalSize.height,
        centroid.dy * imageScaledSize.width / imageOrignalSize.width);
  }
}
