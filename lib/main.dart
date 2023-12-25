import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_bool_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
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
import 'package:visual_scripting/legend.dart';

final LocalStorage storage = LocalStorage('VSDemo');

void main() async {
  await storage.ready;
  runApp(const MyApp());
}

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
                title: "Parse double node",
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
                title: "Sum node",
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
        ],
      ),
      VSSubgroup(
        name: "Logik",
        subgroup: [
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
            name: "Output",
            outputFunction: (data) => controller.text,
          ),
          child: Expanded(child: input),
          setValue: (value) => controller.text = value,
          getValue: () => controller.text,
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
      serializedNodes: storage.getItem('nodeData'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VSNodeView(
          provider: nodeDataProvider,
        ),
        const Positioned(
          bottom: 0,
          right: 0,
          child: Legend(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: ElevatedButton(
            onPressed: () async {
              storage.setItem(
                'nodeData',
                nodeDataProvider.serializationManager.serializeNodes(
                  nodeDataProvider.data,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Saved'),
                ),
              );
            },
            child: const Text("Save"),
          ),
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

//TODO: Use Nodebuilder to deserialize nodes to keep function ref 