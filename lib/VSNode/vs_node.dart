import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/vs_node_input.dart';
import 'package:visual_scripting/VSNode/vs_node_output.dart';

class VSNode extends StatefulWidget {
  const VSNode({
    required this.data,
    super.key,
  });

  final VSNodeData data;

  @override
  State<VSNode> createState() => _VSNodeState();
}

class _VSNodeState extends State<VSNode> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> interfaceWidgets = [];

    for (final value in widget.data.inputData) {
      interfaceWidgets.add(
        VSNodeInput(
          data: value,
        ),
      );
    }

    for (final value in widget.data.outputData) {
      interfaceWidgets.add(
        VSNodeOutput(
          data: value,
        ),
      );
    }

    return Draggable(
      onDragEnd: (details) {
        context.read<VSNodeDataProvider>().setData(
              widget.data..widgetOffset = details.offset,
            );
      },
      feedback: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(widget.data.title),
            const SizedBox(
              width: 100,
            )
          ]),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.data.title),
              ...interfaceWidgets,
            ],
          ),
        ),
      ),
    );
  }
}
