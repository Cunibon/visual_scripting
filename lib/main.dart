import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterafaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/vs_node_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final nodeBuilders = {
      "Dynamic": {
        "Simple dynamic node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple dynamic node",
              widgetOffset: offset,
              inputData: [
                VSDynmaicInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSDynamicOutputData(name: "input"),
              ],
            ),
        "Double input": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Double input",
              widgetOffset: offset,
              inputData: [
                VSDynmaicInputData(
                  name: "input",
                  initialConnection: ref,
                ),
                VSDynmaicInputData(name: "input"),
              ],
              outputData: [
                VSDynamicOutputData(name: "output"),
              ],
            ),
        "Double output": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Double output",
              widgetOffset: offset,
              inputData: [
                VSDynmaicInputData(name: "input", initialConnection: ref),
              ],
              outputData: [
                VSDynamicOutputData(name: "output"),
                VSDynamicOutputData(name: "output"),
              ],
            ),
      },
      "Numbers": {
        "Simple int node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple int node",
              widgetOffset: offset,
              inputData: [
                VSIntInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSIntOutputData(name: "output"),
              ],
            ),
        "Simple double node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple double node",
              widgetOffset: offset,
              inputData: [
                VSDoubleInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSDoubleOutputData(name: "output"),
              ],
            ),
        "Simple num node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple num node",
              widgetOffset: offset,
              inputData: [
                VSNumInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSNumOutputData(name: "output"),
              ],
            ),
      },
      "Simple string node": (Offset offset, VSOutputData? ref) => VSNodeData(
            title: "Simple string node",
            widgetOffset: offset,
            inputData: [
              VSStringInputData(
                name: "input",
                initialConnection: ref,
              )
            ],
            outputData: [
              VSStringOutputData(name: "output"),
            ],
          ),
    };

    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46)),
      home: Scaffold(
        body: VSNodeView(
          nodeBuilders: nodeBuilders,
        ),
      ),
    );
  }
}
