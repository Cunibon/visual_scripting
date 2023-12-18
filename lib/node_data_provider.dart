import 'package:flutter/material.dart';
import 'package:visual_scripting/common.dart';

class VSNodeData {
  VSNodeData({
    required this.title,
    required this.widgetOffset,
    required this.inputData,
    required this.outputData,
  }) : id = getRandomString(10) {
    for (var value in inputData) {
      value.nodeData = this;
    }
    for (var value in outputData) {
      value.nodeData = this;
    }
  }

  final String id;
  String title;
  Offset widgetOffset;
  Iterable<VSInputData> inputData;
  Iterable<VSOutputData> outputData;

  VSNodeData copyWith({
    Offset? widgetOffset,
    String? title,
    Iterable<VSInputData>? inputData,
    Iterable<VSOutputData>? outputData,
  }) =>
      VSNodeData(
        widgetOffset: widgetOffset ?? this.widgetOffset,
        title: title ?? this.title,
        inputData: inputData ?? this.inputData,
        outputData: outputData ?? this.outputData,
      );
}

class VSInterfaceData {
  VSInterfaceData({required this.name});

  final String name;
  late VSNodeData nodeData;
  Offset? widgetOffset;
}

class VSInputData extends VSInterfaceData {
  VSInputData({
    required super.name,
    this.connectedNode,
  });

  VSOutputData? connectedNode;
}

class VSOutputData extends VSInterfaceData {
  VSOutputData({
    required super.name,
  });
}

class NodeDataProvider extends ChangeNotifier {
  Map<String, VSNodeData> _data = {};

  Map<String, VSNodeData> get data => _data;

  void setData(VSNodeData nodeData) async {
    _data = Map.from(_data..[nodeData.id] = nodeData);
    notifyListeners();
  }
}
