import 'package:app_agri/simple_diagram_editor/data/custom_component_data.dart';
import 'package:app_agri/simple_diagram_editor/data/custom_link_data.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin MyInitPolicy implements InitPolicy {



  @override
  initializeDiagramEditor() {
    canvasWriter.state.setCanvasColor(Colors.white);

    // Adding initial components

    String componentId1 = canvasWriter.model.addComponent(
      ComponentData(
        position: const Offset(150, 50),
        size: const Size(120, 72),
        data: MyComponentData(
          text: 'O Organic matter',
          color: Colors.white,
          borderColor: Colors.black,
          borderWidth: 2.0,
        ),
        type: 'rect',
      ),
    );
    String componentId3 = canvasWriter.model.addComponent(
      ComponentData(
        position: const Offset(150, 350),
        size: const Size(120, 72),
        data: MyComponentData(
          text: 'C Substratum',
          color: Colors.white,
          borderColor: Colors.black,
          borderWidth: 2.0,
        ),
        type: 'rect',
      ),
    );

    canvasWriter.model.connectTwoComponents(
      sourceComponentId: componentId1,
      targetComponentId: componentId3,
      linkStyle: LinkStyle(
        arrowType: ArrowType.pointedArrow,
        lineWidth: 1.5,
      ),
      data: MyLinkData(),
    );
  }
}
