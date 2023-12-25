import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:visual_scripting/VSNode/Data/offset_extension.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String _getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );

class VSNodeData {
  VSNodeData({
    String? id,
    required this.title,
    required this.widgetOffset,
    required this.inputData,
    required this.outputData,
  }) : _id = id ?? _getRandomString(10) {
    for (var value in inputData) {
      value.nodeData = this;
    }
    for (var value in outputData) {
      value.nodeData = this;
    }
  }

  String _id;
  String get id => _id;
  String title;
  Offset widgetOffset;
  Iterable<VSInputData> inputData;
  Iterable<VSOutputData> outputData;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'widgetOffset': widgetOffset.toJson(),
      "inputData": inputData.map((e) => e.toJson()).toList(),
      "outputData": outputData.map((e) => e.toJson()).toList(),
    };
  }

  void deserialize(
    String id,
    Offset widgetOffset,
  ) {
    _id = id;
    this.widgetOffset = widgetOffset;
  }

  void setRefData(Map<String, VSOutputData> inputRefs) {
    Map<String, VSInputData> inputMap = {
      for (final element in inputData) element.name: element
    };

    for (final ref in inputRefs.entries) {
      inputMap[ref.key]?.connectedNode = ref.value;
    }
  }
}
