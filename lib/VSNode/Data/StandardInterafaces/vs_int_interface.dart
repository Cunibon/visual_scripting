import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSIntInputData extends VSInputData {
  VSIntInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  List<Type> get acceptedTypes => [VSIntOutputData];

  @override
  Color get interfaceColor => Colors.blue;
}

class VSIntOutputData extends VSOutputData {
  VSIntOutputData({
    required super.name,
  });

  @override
  Color get interfaceColor => Colors.blue;
}
