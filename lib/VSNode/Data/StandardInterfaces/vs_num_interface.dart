import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSNumInputData extends VSInputData {
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
  Color get interfaceColor => Colors.purple;
}

class VSNumOutputData extends VSOutputData<num> {
  VSNumOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.purple;
}
