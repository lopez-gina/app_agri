import 'package:app_agri/simple_diagram_editor/data/custom_component_data.dart';
import 'package:diagram_editor/diagram_editor.dart';
import 'package:flutter/material.dart';

mixin CustomStatePolicy implements PolicySet {
  bool isGridVisible = false; //gl

  List<Map<String, String>> bodies2 = [
    {'Evaporation': 'rect'},
    {'Nitrogen fixation by bacteria in roots': 'rect'},
    {'Absorption of N₂ in animals': 'rect'},
    {'Precipitation': 'rect'},
    {'Denitrification by bacteria': 'rect'},
    {'Ammonification': 'rect'},
    {'Nitrification by bacteria': 'rect'},
    {'Assimilation in plants': 'rect'},
    {'Infiltration': 'rect'},
    {'N₂ in the atmosphere': 'bean'},
    {'NH₃': 'bean'},
    {'Animals/Decomposer': 'bean'},
    {'Plants': 'bean'},
    {'N₂O₅': 'bean'},
    {'N₂O₃': 'bean'},
    {'NH₄⁺': 'bean'},
    {'N₂O': 'bean'},
    {'NO₂⁻': 'bean'},
    {'NO₃⁻': 'bean'},
  ];

  List<Map<String, String>> bodies = [
    {'A Surface': 'rect'},
    {'B Topsoil': 'rect'},
    {'B Subsoil': 'rect'},
    {'B Parent material': 'rect'},
    {'B Solid bedrock': 'rect'},
    {'C Sediment': 'rect'},
    {'C Substratum': 'rect'},
    {'R Bedrock': 'rect'},
    {'O Organic matter': 'rect'},
    // {'rect': 'rect'},
    // {'bean': 'bean'},
  ];

  String? selectedComponentId;

  bool isMultipleSelectionOn = false;
  List<String?> multipleSelected = [];

  Offset deleteLinkPos = Offset.zero;

  bool isReadyToConnect = false;

  String? selectedLinkId;
  Offset tapLinkPosition = Offset.zero;

  hideAllHighlights() {
    canvasWriter.model.hideAllLinkJoints();
    hideLinkOption();
    canvasReader.model.getAllComponents().values.forEach((component) {
      if (component.data.isHighlightVisible) {
        component.data.hideHighlight();
        canvasWriter.model.updateComponent(component.id);
      }
    });
  }

  highlightComponent(String componentId) {
    canvasReader.model.getComponent(componentId).data.showHighlight();
    canvasReader.model.getComponent(componentId).updateComponent();
  }

  hideComponentHighlight(String componentId) {
    canvasReader.model.getComponent(componentId).data.hideHighlight();
    canvasReader.model.getComponent(componentId).updateComponent();
  }

  turnOnMultipleSelection() {
    isMultipleSelectionOn = true;
    isReadyToConnect = false;

    if (selectedComponentId != null) {
      addComponentToMultipleSelection(selectedComponentId);
      selectedComponentId = null;
    }
  }

  turnOffMultipleSelection() {
    isMultipleSelectionOn = false;
    multipleSelected = [];
    hideAllHighlights();
  }

  addComponentToMultipleSelection(String? componentId) {
    if (componentId == null) return;
    if (!multipleSelected.contains(componentId)) {
      multipleSelected.add(componentId);
    }
  }

  removeComponentFromMultipleSelection(String componentId) {
    multipleSelected.remove(componentId);
  }

  String duplicate(ComponentData componentData) {
    var cd = ComponentData(
      type: componentData.type,
      size: componentData.size,
      minSize: componentData.minSize,
      data: MyComponentData.copy(componentData.data),
      position: componentData.position + const Offset(20, 20),
    );
    String id = canvasWriter.model.addComponent(cd);
    return id;
  }

  showLinkOption(String linkId, Offset position) {
    selectedLinkId = linkId;
    tapLinkPosition = position;
  }

  hideLinkOption() {
    selectedLinkId = null;
  }
}

mixin CustomBehaviourPolicy implements PolicySet, CustomStatePolicy {
  removeAll() {
    canvasWriter.model.removeAllComponents();
  }

  resetView() {
    canvasWriter.state.resetCanvasView();
  }

  removeSelected() {
    for (var componentId in multipleSelected) {
      if (componentId == null) continue;
      canvasWriter.model.removeComponent(componentId);
    }
    multipleSelected = [];
  }

  duplicateSelected() {
    List<String> duplicated = [];
    for (var componentId in multipleSelected) {
      if (componentId == null) continue;
      String newId = duplicate(canvasReader.model.getComponent(componentId));
      duplicated.add(newId);
    }
    hideAllHighlights();
    multipleSelected = [];
    for (var componentId in duplicated) {
      addComponentToMultipleSelection(componentId);
      highlightComponent(componentId);
      canvasWriter.model.moveComponentToTheFront(componentId);
    }
  }

  selectAll() {
    var components = canvasReader.model.canvasModel.components.keys;

    for (var componentId in components) {
      addComponentToMultipleSelection(componentId);
      highlightComponent(componentId);
    }
  }
}
