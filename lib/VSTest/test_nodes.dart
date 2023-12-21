import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandartInterafaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

VSNodeData buildSimpleNode(Offset offset, VSOutputData? ref) => VSNodeData(
      title: "New Node",
      widgetOffset: offset,
      inputData: [
        VSDynmaicInputData(
          name: "input",
          connectedNode: ref,
        )
      ],
      outputData: [
        VSDynamicOutputData(name: "input"),
      ],
    );

VSNodeData buildDoubleOutput(Offset offset, VSOutputData? ref) => VSNodeData(
      title: "Double output",
      widgetOffset: offset,
      inputData: [
        VSDynmaicInputData(name: "input", connectedNode: ref),
      ],
      outputData: [
        VSDynamicOutputData(name: "input"),
        VSDynamicOutputData(name: "input"),
      ],
    );

VSNodeData buildDoubleInput(Offset offset, VSOutputData? ref) => VSNodeData(
      title: "Double input",
      widgetOffset: offset,
      inputData: [
        VSDynmaicInputData(
          name: "input",
          connectedNode: ref,
        ),
        VSDynmaicInputData(name: "input"),
      ],
      outputData: [
        VSDynamicOutputData(name: "input"),
      ],
    );
