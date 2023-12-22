import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSDynamicInputData extends VSInputData {
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
  Color get interfaceColor => Colors.grey;
}

class VSDynamicOutputData extends VSOutputData<dynamic> {
  VSDynamicOutputData({
    required super.name,
    required super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.grey;
}
