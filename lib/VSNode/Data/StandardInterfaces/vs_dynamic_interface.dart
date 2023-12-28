import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

const Color _interfaceColor = Colors.grey;

class VSDynamicInputData extends VSInputData {
  ///Basic dynamic input interface
  VSDynamicInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [];

  @override
  bool acceptInput(VSOutputData? data) {
    return true;
  }

  @override
  Color get interfaceColor => _interfaceColor;
}

class VSDynamicOutputData extends VSOutputData<dynamic> {
  ///Basic dynamic output interface
  VSDynamicOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => _interfaceColor;
}
