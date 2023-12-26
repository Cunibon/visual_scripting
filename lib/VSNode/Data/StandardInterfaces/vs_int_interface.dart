import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSIntInputData extends VSInputData {
  ///Basic int input interface
  VSIntInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSIntOutputData, VSNumOutputData];

  @override
  Color get interfaceColor => Colors.blue;
}

class VSIntOutputData extends VSOutputData<int> {
  ///Basic int output interface
  VSIntOutputData({
    required super.name,
    super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.blue;
}
