import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSNumInputData extends VSInputData {
  VSNumInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  List<Type> get acceptedTypes => [VSDoubleOutputData, VSIntOutputData];

  @override
  Color get interfaceColor => Colors.purple;
}

class VSNumOutputData extends VSOutputData {
  VSNumOutputData({
    required super.name,
  });

  @override
  Color get interfaceColor => Colors.purple;
}
