import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSStringInputData extends VSInputData {
  VSStringInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  List<Type> get acceptedTypes => [VSStringOutputData];

  @override
  Color get interfaceColor => Colors.red;
}

class VSStringOutputData extends VSOutputData {
  VSStringOutputData({
    required super.name,
  });

  @override
  Color get interfaceColor => Colors.red;
}
