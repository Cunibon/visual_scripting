import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSStringInputData extends VSInputData {
  VSStringInputData({
    required super.name,
    super.initialConnection,
  });

  @override
  List<Type> get acceptedTypes => [VSStringOutputData];

  @override
  Color get interfaceColor => Colors.green;
}

class VSStringOutputData extends VSOutputData<String> {
  VSStringOutputData({
    required super.name,
    required super.outputFunction,
  });

  @override
  Color get interfaceColor => Colors.green;
}
