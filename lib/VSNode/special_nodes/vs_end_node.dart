import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class VSEndNode extends VSNodeData {
  VSEndNode({
    required String title,
    required Offset widgetOffset,
  }) : super(
          title: title,
          widgetOffset: widgetOffset,
          inputData: [VSDynamicInputData(name: title)],
          outputData: const [],
        );

  dynamic evalGraph({Function(Object e, StackTrace s)? onError}) {
    try {
      Map<String, List<dynamic>> nodeInputValues = {};
      traverseInputNodes(nodeInputValues, this);

      return nodeInputValues[id]!.first;
    } catch (e, s) {
      onError?.call(e, s);
    }
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
          connectedNode.outputFunction?.call(
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
