import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';

class VSContextMenu extends StatefulWidget {
  const VSContextMenu({
    required this.nodeBuilders,
    super.key,
  });

  final Map<String, dynamic> nodeBuilders;

  @override
  State<VSContextMenu> createState() => _VSContextMenuState();
}

class _VSContextMenuState extends State<VSContextMenu> {
  late Map<String, dynamic> nodeBuilders;

  @override
  void initState() {
    super.initState();
    nodeBuilders = widget.nodeBuilders;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    final entries = nodeBuilders.entries;

    for (final entry in entries) {
      if (entry.value is Map) {
        widgets.add(
          TextButton(
            onPressed: () => setState(() {
              nodeBuilders = entry.value;
            }),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      } else {
        widgets.add(TextButton(
          onPressed: () {
            final dataProvider = context.read<VSNodeDataProvider>();
            dataProvider.createNode(entry.value);
            dataProvider.closeContextMenu();
          },
          child: Text(entry.key),
        ));
      }
      if (entry.key != entries.last.key) {
        widgets.add(const Divider());
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      ),
    );
  }
}
