import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSDynmaicInputData extends VSInputData {
  VSDynmaicInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  List<Type> get acceptedTypes => [];

  @override
  bool acceptInput(VSOutputData data) {
    return true;
  }

  @override
  Color get interfaceColor => Colors.grey;
}

class VSDynamicOutputData extends VSOutputData {
  VSDynamicOutputData({
    required super.name,
  });

  @override
  Color get interfaceColor => Colors.grey;
}
