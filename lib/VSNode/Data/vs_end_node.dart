import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class EndNode extends VSNodeData {
  EndNode({
    required String title,
    required Offset widgetOffset,
  }) : super(
          title: title,
          widgetOffset: widgetOffset,
          inputData: [VSDynamicInputData(name: title)],
          outputData: const [],
        );

  dynamic evalGraph() {
    Map<String, List<dynamic>> nodeInputValues = {};
    traverseInputNodes(nodeInputValues, this);

    return nodeInputValues[id]!.first;
  }

  void traverseInputNodes(
    Map<String, List<dynamic>> nodeInputValues,
    VSNodeData data,
  ) {
    List<dynamic> inputValues = [];
    for (final input in data.inputData) {
      final connectedNode = input.connectedNode;
      if (connectedNode != null) {
        if (!nodeInputValues.containsKey(connectedNode.nodeData.id)) {
          traverseInputNodes(
            nodeInputValues,
            connectedNode.nodeData,
          );
        }

        inputValues.add(
          connectedNode.outputFunction(
            nodeInputValues[connectedNode.nodeData.id]!,
          ),
        );
      } else {
        inputValues.add(null);
      }
    }
    nodeInputValues[data.id] = inputValues;
  }
}
