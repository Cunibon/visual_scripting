import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_subgroup.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_end_node.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_widget_node.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_view.dart';
import 'package:visual_scripting/legend.dart';
import 'package:visual_scripting/logik_nodes.dart';
import 'package:visual_scripting/number_nodes.dart';

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
        subgroup: numberNodes,
      ),
      VSSubgroup(
        name: "Logik",
        subgroup: logikNodes,
      ),
      (Offset offset, VSOutputData? ref) {
        final controller = TextEditingController();
        final input = TextField(
          controller: controller,
        );

        return VSWidgetNode(
          type: "Input",
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
      (Offset offset, VSOutputData? ref) => VSOutputNode(
            type: "Output",
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
                nodeDataProvider.nodeManger.serializeNodes(),
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
                  results = nodeDataProvider.nodeManger.getOutputNodes.map(
                    (e) => e
                        .evalTree(
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