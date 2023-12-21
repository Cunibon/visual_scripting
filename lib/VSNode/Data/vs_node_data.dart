import 'dart:math';

import 'package:flutter/gestures.dart';
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
    required this.title,
    required this.widgetOffset,
    required this.inputData,
    required this.outputData,
  }) : id = _getRandomString(10) {
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
}
