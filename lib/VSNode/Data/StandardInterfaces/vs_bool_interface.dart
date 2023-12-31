import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

const Color _interfaceColor = Colors.orange;

class VSBoolInputData extends VSInputData {
  ///Basic boolean input interface
  VSBoolInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSBoolOutputData];

  @override
  Color get interfaceColor => _interfaceColor;
}

class VSBoolOutputData extends VSOutputData<bool> {
  ///Basic boolean output interface
  VSBoolOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => _interfaceColor;
}
