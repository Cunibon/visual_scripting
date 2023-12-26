import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';

List<VSNodeDataBuilder> numberNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Parse int node",
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
        type: "Parse double node",
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
        type: "Sum node",
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
