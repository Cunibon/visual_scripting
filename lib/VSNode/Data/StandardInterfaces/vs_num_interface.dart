import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

const Color _interfaceColor = Colors.purple;

class VSNumInputData extends VSInputData {
  ///Basic num input interface
  VSNumInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [
        VSDoubleOutputData,
        VSIntOutputData,
        VSNumOutputData,
      ];

  @override
  Color get interfaceColor => _interfaceColor;
}

class VSNumOutputData extends VSOutputData<num> {
  ///Basic num output interface
  VSNumOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => _interfaceColor;
}
