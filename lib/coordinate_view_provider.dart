import 'package:flutter/material.dart';

class VSNodeData {
  VSNodeData({
    required this.title,
    required this.widgetOffset,
    required this.inputs,
    required this.outputs,
  });

  String title;
  Offset widgetOffset;
  Map<String, VSNodeData?> inputs;
  Map<String, Function?> outputs;

  VSNodeData copyWith({
    Offset? widgetOffset,
    String? title,
    Map<String, VSNodeData?>? inputs,
    Map<String, Function?>? outputs,
  }) =>
      VSNodeData(
        widgetOffset: widgetOffset ?? this.widgetOffset,
        title: title ?? this.title,
        inputs: inputs ?? this.inputs,
        outputs: outputs ?? this.outputs,
      );
}

class CoordinateProvider extends ChangeNotifier {
  Map<String, VSNodeData> _data = {};

  Map<String, VSNodeData> get data => _data;

  void setData(VSNodeData nodeData) async {
    _data = Map.from(_data..[nodeData.title] = nodeData);
    notifyListeners();
  }
}
