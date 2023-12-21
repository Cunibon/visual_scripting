import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSDoubleInputData extends VSInputData {
  VSDoubleInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  List<Type> get acceptedTypes => [VSDoubleOutputData, VSNumOutputData];

  @override
  Color get interfaceColor => Colors.red;
}

class VSDoubleOutputData extends VSOutputData {
  VSDoubleOutputData({
    required super.name,
  });

  @override
  Color get interfaceColor => Colors.red;
}
