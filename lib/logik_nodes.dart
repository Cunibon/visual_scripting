import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_bool_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';

List<VSNodeDataBuilder> logikNodes = [
  (Offset offset, VSOutputData? ref) => VSNodeData(
        title: "Bigger then",
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
        title: "The same",
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
        title: "If node",
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
