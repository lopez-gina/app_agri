import 'package:app_agri/simple_diagram_editor/widget/component/bean_component.dart';
import 'package:app_agri/simple_diagram_editor/widget/component/rect_component.dart';

import 'package:diagram_editor/diagram_editor.dart';

import 'package:flutter/material.dart';

mixin MyComponentDesignPolicy implements ComponentDesignPolicy {
  @override
  Widget showComponentBody(ComponentData componentData) {
    switch (componentData.type) {
      case 'rect':
        return RectBody(componentData: componentData);
      case 'bean':
        return BeanBody(componentData: componentData);
      default:
        return const SizedBox.shrink();
    }
  }
}
