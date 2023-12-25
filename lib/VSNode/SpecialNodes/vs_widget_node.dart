import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class VSWidgetNode extends VSNodeData {
  VSWidgetNode({
    String? id,
    required String title,
    required Offset widgetOffset,
    required VSOutputData<dynamic> outputData,
    required this.setValue,
    required this.getValue,
    required this.child,
  }) : super(
          id: id,
          title: title,
          widgetOffset: widgetOffset,
          inputData: const [],
          outputData: [outputData],
        );

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();

    return json..["value"] = getValue();
  }

  final Widget child;
  final Function(dynamic) setValue;
  final dynamic Function() getValue;
}
