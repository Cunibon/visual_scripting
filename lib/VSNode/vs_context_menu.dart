import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';

class VSContextMenu extends StatelessWidget {
  const VSContextMenu({
    required this.nodeBuilders,
    super.key,
  });

  final Map<String, VSNodeDataBuilder> nodeBuilders;

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
              ...nodeBuilders.entries.map((e) => TextButton(
                    onPressed: () {
                      final dataProvider = context.read<VSNodeDataProvider>();
                      dataProvider.createNode(e.value);
                      dataProvider.closeContextMenu();
                    },
                    child: Text(e.key),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
