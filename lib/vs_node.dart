import 'package:flutter/material.dart';
import 'package:visual_scripting/coordinate_view_provider.dart';
import 'package:visual_scripting/vs_node_input.dart';
import 'package:visual_scripting/vs_node_output.dart';

class VSNode extends StatefulWidget {
  const VSNode({
    required this.data,
    required this.scrollOffset,
    super.key,
  });

  final VSNodeData data;
  final Offset scrollOffset;

  @override
  State<VSNode> createState() => _VSNodeState();
}

class _VSNodeState extends State<VSNode> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> interfaceWidgets = [];

    widget.data.inputs.forEach(
      (key, value) => interfaceWidgets.add(
        VSNodeInput(
          title: key,
          scrollOffset: widget.scrollOffset,
          data: widget.data,
        ),
      ),
    );

    widget.data.outputs.forEach(
      (key, value) => interfaceWidgets.add(
        VSNodeOutput(
          title: key,
          scrollOffset: widget.scrollOffset,
          data: widget.data,
        ),
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(widget.data.title),
          ...interfaceWidgets,
        ]),
      ),
    );
  }
}
