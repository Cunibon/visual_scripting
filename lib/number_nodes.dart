import 'package:flutter/material.dart';
import 'package:vs_node_view/common.dart';
import 'package:vs_node_view/vs_node_view.dart';

List<VSNodeDataBuilder> numberNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Parse int",
        toolTip: "Parses a String to an Integer",
        widgetOffset: offset,
        inputData: [
          VSStringInputData(
            type: "Input",
            toolTip: "The String to be parsed",
            initialConnection: ref,
          )
        ],
        outputData: [
          VSIntOutputData(
            type: "Output",
            toolTip: "The parsed Integer",
            outputFunction: (data) => int.parse(data["Input"]),
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Parse double",
        toolTip: "Parses a String to an Double",
        widgetOffset: offset,
        inputData: [
          VSStringInputData(
            type: "Input",
            toolTip: "The String to be parsed",
            initialConnection: ref,
          )
        ],
        outputData: [
          VSDoubleOutputData(
            type: "Output",
            toolTip: "The parsed Double",
            outputFunction: (data) => double.parse(data["Input"]),
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSListNode(
        type: "Sum",
        toolTip: "Adds all supplied Numbers together",
        widgetOffset: offset,
        inputBuilder: (index, connection) => VSNumInputData(
          type: "Input $index",
          initialConnection: connection,
        ),
        outputData: [
          VSNumOutputData(
            type: "output",
            toolTip: "The sum of all supplied values",
            outputFunction: (data) {
              return data.values.reduce((value, element) => value + element);
            },
          )
        ],
      ),
];
