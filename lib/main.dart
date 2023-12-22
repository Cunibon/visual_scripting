import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/vs_node_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46)),
      home: const Scaffold(body: ShowResult()),
    );
  }
}

class ShowResult extends StatefulWidget {
  const ShowResult({super.key});

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  String? result;

  final nodeDataProvider = VSNodeDataProvider();

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
        "Sum node": (Offset offset, VSOutputData? ref) => VSNodeData(
              title: "Sum node",
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
                      if (number != null) {
                        sum += number as num;
                      }
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
    };

    return Stack(
      children: [
        VSNodeView(
          nodeBuilders: nodeBuilders,
          provider: nodeDataProvider,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  result = nodeDataProvider.getEndNode.evalGraph().toString();
                }),
                child: const Text("Evaluate"),
              ),
              if (result != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result!),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
