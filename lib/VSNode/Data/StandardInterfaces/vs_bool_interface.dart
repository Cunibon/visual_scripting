import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSBoolInputData extends VSInputData {
  VSBoolInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSBoolOutputData];

  @override
  Color get interfaceColor => Colors.yellow;
}

class VSBoolOutputData extends VSOutputData<double> {
  VSBoolOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.yellow;
}
