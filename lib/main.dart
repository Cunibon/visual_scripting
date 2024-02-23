import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:visual_scripting/legend.dart';
import 'package:visual_scripting/logik_nodes.dart';
import 'package:visual_scripting/number_nodes.dart';
import 'package:vs_node_view/vs_node_view.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46),
      ),
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
      (Offset offset, VSOutputData? ref) => VSListNode(
            type: "Concat",
            toolTip: "Concatinates all inputs",
            widgetOffset: offset,
            outputData: [
              VSStringOutputData(
                type: "Output",
                toolTip: "All inputs concatinated",
                outputFunction: (data) => data.values.join(),
              )
            ],
            inputBuilder: (index, ref) => VSDynamicInputData(
              type: "$index",
              title: "$index input",
              initialConnection: ref,
            ),
          ),
      (Offset offset, VSOutputData? ref) {
        final controller = TextEditingController();
        final input = TextField(
          controller: controller,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          ),
        );

        return VSWidgetNode(
          type: "Input",
          toolTip: "A user input",
          widgetOffset: offset,
          outputData: VSStringOutputData(
            type: "Output",
            toolTip: "The users input as a String",
            outputFunction: (data) => controller.text,
          ),
          child: Expanded(child: input),
          setValue: (value) => controller.text = value,
          getValue: () => controller.text,
        );
      },
      (Offset offset, VSOutputData? ref) => VSOutputNode(
            type: "Output",
            toolTip: "Will output this tree",
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
        InteractiveVSNodeView(
          width: 5000,
          height: 5000,
          scaleFactor: 300,
          nodeDataProvider: nodeDataProvider,
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
                  final entries =
                      nodeDataProvider.nodeManger.getOutputNodes.map(
                    (e) => e.evaluate(
                      onError: (_, __) => Future.delayed(Duration.zero, () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.deepOrange,
                            content: Text('An error occured'),
                          ),
                        );
                      }),
                    ),
                  );

                  results = entries.map((e) => "${e.key}: ${e.value}");
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
