import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

class VSIntInputData extends VSInputData {
  VSIntInputData({
    required super.name,
    super.connectedNode,
  });

  @override
  Type get acceptedType => int;

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
