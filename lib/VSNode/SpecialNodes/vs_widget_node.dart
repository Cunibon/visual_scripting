import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class VSWidgetNode extends VSNodeData {
  VSWidgetNode({
    required String title,
    required Offset widgetOffset,
    required VSOutputData<dynamic> outputData,
    required this.child,
  }) : super(
          title: title,
          widgetOffset: widgetOffset,
          inputData: const [],
          outputData: [outputData],
        );

  final Widget child;
}
