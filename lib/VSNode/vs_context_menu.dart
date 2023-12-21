import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';
import 'package:visual_scripting/VSTest/test_nodes.dart';

class VSContextMenu extends StatelessWidget {
  const VSContextMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  final dataProvider = context.read<VSNodeDataProvider>();
                  dataProvider.createNode(buildSimpleNode);
                  dataProvider.closeContextMenu();
                },
                child: const Text("Simple Node"),
              ),
              TextButton(
                onPressed: () {
                  final dataProvider = context.read<VSNodeDataProvider>();
                  dataProvider.createNode(buildDoubleInput);
                  dataProvider.closeContextMenu();
                },
                child: const Text("Double input"),
              ),
              TextButton(
                onPressed: () {
                  final dataProvider = context.read<VSNodeDataProvider>();
                  dataProvider.createNode(buildDoubleOutput);
                  dataProvider.closeContextMenu();
                },
                child: const Text("Double output"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
