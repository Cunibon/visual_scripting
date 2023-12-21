import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

abstract class VSInterfaceData {
  VSInterfaceData({required this.name});

  Color get interfaceColor;

  final String name;
  late VSNodeData nodeData;
  Offset? widgetOffset;
}

abstract class VSInputData extends VSInterfaceData {
  VSInputData({
    required super.name,
    this.connectedNode,
  });

  Type get acceptedType;
  VSOutputData? connectedNode;
}

abstract class VSOutputData extends VSInterfaceData {
  VSOutputData({
    required super.name,
  });
}
