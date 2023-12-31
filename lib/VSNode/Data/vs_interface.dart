import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

///Base interface class
///Used for base input and output interface
abstract class VSInterfaceData {
  VSInterfaceData({required this.name});

  Color get interfaceColor;

  final String name;
  late VSNodeData nodeData;
  Offset? widgetOffset;
}

///Base input interface
///Makes sure only correct types can be connected
///Implemetes toJson
abstract class VSInputData extends VSInterfaceData {
  VSInputData({
    required super.name,
    VSOutputData? initialConnection,
  }) {
    connectedNode = initialConnection;
  }

  VSOutputData? _connectedNode;
  VSOutputData? get connectedNode => _connectedNode;
  set connectedNode(VSOutputData? data) {
    if (data == null || acceptInput(data)) {
      _connectedNode = data;
    }
  }

  List<Type> get acceptedTypes;
  bool acceptInput(VSOutputData data) {
    return acceptedTypes.contains(data.runtimeType) ||
        data.runtimeType == VSDynamicOutputData;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "connectedNode": connectedNode?.toJson(),
    };
  }
}

///Base output interface
///Implemetes toJson
abstract class VSOutputData<T> extends VSInterfaceData {
  VSOutputData({
    required super.name,
    this.outputFunction,
  });

  final T Function(Map<String, dynamic>)? outputFunction;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "nodeData": nodeData.id,
    };
  }
}
