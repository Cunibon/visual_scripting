import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/vs_node_view.dart';
import 'package:visual_scripting/VSNode/vs_node_view_controller.dart';

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
                VSDynamicInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSDynamicOutputData(
                  name: "output",
                  outputFunction: (data) => data.first,
                ),
              ],
            ),
      },
      "Numbers": {
        "Simple int node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple int node",
              widgetOffset: offset,
              inputData: [],
              outputData: [
                VSIntOutputData(
                  name: "5",
                  outputFunction: (data) => 5,
                ),
              ],
            ),
        "Simple double node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Simple double node",
              widgetOffset: offset,
              inputData: [],
              outputData: [
                VSDoubleOutputData(
                  name: "2.5",
                  outputFunction: (data) => 2.5,
                ),
              ],
            ),
        "sum node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "sum node",
              widgetOffset: offset,
              inputData: [
                VSNumInputData(
                  name: "input",
                  initialConnection: ref,
                ),
                VSNumInputData(
                  name: "input",
                  initialConnection: ref,
                )
              ],
              outputData: [
                VSNumOutputData(
                  name: "output",
                  outputFunction: (data) {
                    num sum = 0;
                    for (final number in data) {
                      sum += number as num;
                    }
                    return sum;
                  },
                ),
              ],
            ),
      },
      "To string": (Offset offset, VSOutputData? ref) => VSNodeData(
            title: "To string",
            widgetOffset: offset,
            inputData: [
              VSDynamicInputData(
                name: "input",
                initialConnection: ref,
              )
            ],
            outputData: [
              VSStringOutputData(
                name: "output",
                outputFunction: (data) => data.first.toString(),
              ),
            ],
          ),
      "Print": (Offset offset, VSOutputData? ref) => VSNodeData(
            title: "Print",
            widgetOffset: offset,
            inputData: [
              VSDynamicInputData(
                name: "input",
                initialConnection: ref,
              )
            ],
            outputData: [
              VSDynamicOutputData(
                name: "output",
                outputFunction: (data) => print(data),
              ),
            ],
          ),
    };

    final controller = VSNodeViewController();

    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46)),
      home: Scaffold(
        body: Stack(
          children: [
            VSNodeView(
              nodeBuilders: nodeBuilders,
              controller: controller,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () => print(
                  controller.vsNodeDataProvider.getEndNode.evalGraph(),
                ),
                child: const Text("Evaluate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
