import 'package:flutter/material.dart';
import 'package:vs_node_view/data/vs_node_data_provider.dart';
import 'package:vs_node_view/vs_node_view.dart';

List<VSNodeDataBuilder> numberNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Parse int",
        widgetOffset: offset,
        inputData: [
          VSStringInputData(
            name: "Input",
            initialConnection: ref,
          )
        ],
        outputData: [
          VSIntOutputData(
            name: "Output",
            outputFunction: (data) => int.parse(data["Input"]),
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Parse double",
        widgetOffset: offset,
        inputData: [
          VSStringInputData(
            name: "Input",
            initialConnection: ref,
          )
        ],
        outputData: [
          VSDoubleOutputData(
            name: "Output",
            outputFunction: (data) => double.parse(data["Input"]),
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Sum",
        widgetOffset: offset,
        inputData: [
          VSNumInputData(
            name: "Input 1",
            initialConnection: ref,
          ),
          VSNumInputData(
            name: "Input 2",
            initialConnection: ref,
          )
        ],
        outputData: [
          VSNumOutputData(
            name: "output",
            outputFunction: (data) {
              return (data["Input 1"] ?? 0) + (data["Input 2"] ?? 0);
            },
          ),
        ],
      ),
];
