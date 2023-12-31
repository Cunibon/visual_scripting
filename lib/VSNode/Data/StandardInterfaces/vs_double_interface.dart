import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

const Color _interfaceColor = Colors.red;

class VSDoubleInputData extends VSInputData {
  ///Basic double input interface
  VSDoubleInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSDoubleOutputData, VSNumOutputData];

  @override
  Color get interfaceColor => _interfaceColor;
}

class VSDoubleOutputData extends VSOutputData<double> {
  ///Basic double output interface
  VSDoubleOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => _interfaceColor;
}
