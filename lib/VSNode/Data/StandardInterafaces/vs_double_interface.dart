import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSDoubleInputData extends VSInputData {
  VSDoubleInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSDoubleOutputData, VSNumOutputData];

  @override
  Color get interfaceColor => Colors.red;
}

class VSDoubleOutputData extends VSOutputData<double> {
  VSDoubleOutputData({
    required super.name,
    required super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.red;
}
