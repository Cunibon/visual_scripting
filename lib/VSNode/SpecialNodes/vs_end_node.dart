import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class VSOutputNode extends VSNodeData {
  VSOutputNode(
      {required String title, required Offset widgetOffset, VSOutputData? ref})
      : super(
          title: title,
          widgetOffset: widgetOffset,
          inputData: [
            VSDynamicInputData(
              name: title,
              initialConnection: ref,
            )
          ],
          outputData: const [],
        );

  dynamic evalGraph({Function(Object e, StackTrace s)? onError}) {
    try {
      Map<String, Map<String, dynamic>> nodeInputValues = {};
      traverseInputNodes(nodeInputValues, this);

      return nodeInputValues[id]!.values.first;
    } catch (e, s) {
      onError?.call(e, s);
    }
  }

  void traverseInputNodes(
    Map<String, Map<String, dynamic>> nodeInputValues,
    VSNodeData data,
  ) {
    Map<String, dynamic> inputValues = {};
    for (final input in data.inputData) {
      final connectedNode = input.connectedNode;
      if (connectedNode != null) {
        if (!nodeInputValues.containsKey(connectedNode.nodeData.id)) {
          traverseInputNodes(
            nodeInputValues,
            connectedNode.nodeData,
          );
        }

        inputValues[input.name] = connectedNode.outputFunction?.call(
          nodeInputValues[connectedNode.nodeData.id]!,
        );
      } else {
        inputValues[input.name] = null;
      }
    }
    nodeInputValues[data.id] = inputValues;
  }
}
