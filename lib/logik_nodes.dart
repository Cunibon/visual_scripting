import 'package:flutter/material.dart';
import 'package:vs_node_view/common.dart';
import 'package:vs_node_view/vs_node_view.dart';

List<VSNodeDataBuilder> logikNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Bigger then",
        toolTip:
            "Compares two values and outputs if First is bigger then Second",
        widgetOffset: offset,
        inputData: [
          VSNumInputData(
            type: "First",
            toolTip: "The firest value to be compared",
            initialConnection: ref,
          ),
          VSNumInputData(
            type: "Second",
            toolTip: "The second value to be compared",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSBoolOutputData(
            type: "Output",
            toolTip: "The result of 'First > Second'",
            outputFunction: (data) => data["First"] > data["Second"],
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "The same",
        toolTip: "Compares two values and outputs if they are the same",
        widgetOffset: offset,
        inputData: [
          VSDynamicInputData(
            type: "First",
            toolTip: "The firest value to be compared",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            type: "Second",
            toolTip: "The second value to be compared",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSBoolOutputData(
            type: "Output",
            toolTip: "The result of 'First == Second'",
            outputFunction: (data) => data["First"] == data["Second"],
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "If",
        toolTip: "Takes a boolean and switches the output based on the bool",
        widgetOffset: offset,
        inputData: [
          VSBoolInputData(
            type: "Input",
            toolTip: "The boolean to switch on",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            type: "True",
            toolTip: "The value returned if the bool is true",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            type: "False",
            toolTip: "The value returned if the bool is false",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSDynamicOutputData(
            type: "Output",
            toolTip: "The result of 'Input ? True : False'",
            outputFunction: (data) =>
                data["Input"] ? data["True"] : data["False"],
          ),
        ],
      ),
];
