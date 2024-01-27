import 'package:flutter/material.dart';
import 'package:vs_node_view/data/vs_node_data_provider.dart';
import 'package:vs_node_view/vs_node_view.dart';

List<VSNodeDataBuilder> logikNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "Bigger then",
        widgetOffset: offset,
        inputData: [
          VSNumInputData(
            name: "First",
            initialConnection: ref,
          ),
          VSNumInputData(
            name: "Second",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSBoolOutputData(
            name: "Output",
            outputFunction: (data) => data["First"] > data["Second"],
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "The same",
        widgetOffset: offset,
        inputData: [
          VSDynamicInputData(
            name: "First",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            name: "Second",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSBoolOutputData(
            name: "Output",
            outputFunction: (data) => data["First"] == data["Second"],
          ),
        ],
      ),
  (Offset offset, VSOutputData? ref) => VSNodeData(
        type: "If",
        widgetOffset: offset,
        inputData: [
          VSBoolInputData(
            name: "Input",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            name: "True",
            initialConnection: ref,
          ),
          VSDynamicInputData(
            name: "False",
            initialConnection: ref,
          ),
        ],
        outputData: [
          VSDynamicOutputData(
            name: "Output",
            outputFunction: (data) =>
                data["Input"] ? data["True"] : data["False"],
          ),
        ],
      ),
];
