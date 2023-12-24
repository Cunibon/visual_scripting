import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_subgroup.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_end_node.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_widget_node.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_view.dart';

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
  Iterable<String>? results;

  late VSNodeDataProvider nodeDataProvider;

  @override
  void initState() {
    super.initState();

    final nodeBuilders = [
      VSSubgroup(
        name: "Numbers",
        subgroup: [
          (Offset offset, VSOutputData? ref) => VSNodeData(
                title: "Parse int node",
                widgetOffset: offset,
                inputData: [VSStringInputData(name: "Input")],
                outputData: [
                  VSIntOutputData(
                    name: "Output",
                    outputFunction: (data) => int.parse(data.first),
                  ),
                ],
              ),
          (Offset offset, VSOutputData? ref) => VSNodeData(
                title: "Parse double node",
                widgetOffset: offset,
                inputData: [VSStringInputData(name: "Input")],
                outputData: [
                  VSDoubleOutputData(
                    name: "Output",
                    outputFunction: (data) => double.parse(data.first),
                  ),
                ],
              ),
          (Offset offset, VSOutputData? ref) => VSNodeData(
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
        ],
      ),
      (Offset offset, VSOutputData? ref) {
        final controller = TextEditingController();
        final input = TextField(
          controller: controller,
        );

        return VSWidgetNode(
          title: "Input",
          widgetOffset: offset,
          outputData: VSStringOutputData(
            name: "output",
            outputFunction: (data) => controller.text,
          ),
          child: Expanded(child: input),
        );
      },
      (Offset offset, VSOutputData? ref) => VSEndNode(
            title: "Output",
            widgetOffset: offset,
            ref: ref,
          ),
    ];

    nodeDataProvider = VSNodeDataProvider(
      nodeBuilders: nodeBuilders,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VSNodeView(
          provider: nodeDataProvider,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  results = nodeDataProvider.getEndNodes.map(
                    (e) => e
                        .evalGraph(
                          onError: (_, __) => Future.delayed(Duration.zero, () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.deepOrange,
                                content: Text('An error occured'),
                              ),
                            );
                          }),
                        )
                        .toString(),
                  );
                }),
                child: const Text("Evaluate"),
              ),
              if (results != null)
                ...results!.map(
                  (e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

//TODO: From list to map in function input
//TODO: Use Nodebuilder to deserialize nodes to keep function ref 