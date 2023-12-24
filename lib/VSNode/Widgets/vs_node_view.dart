import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_context_menu.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node.dart';

class VSNodeView extends StatelessWidget {
  const VSNodeView({
    required this.provider,
    super.key,
  });

  final VSNodeDataProvider provider;

  @override
  Widget build(BuildContext context) {
    final vsNodeDataProvider = provider;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: vsNodeDataProvider),
      ],
      child: Builder(builder: (context) {
        final nodeDataProvider = context.watch<VSNodeDataProvider>();

        return Stack(
          children: [
            GestureDetector(
              onTapDown: (details) => nodeDataProvider.closeContextMenu(),
              onSecondaryTapUp: (details) {
                nodeDataProvider.openContextMenu(
                  position: details.globalPosition,
                );
              },
            ),
            ...nodeDataProvider.data.values.map((value) {
              return Positioned(
                left: value.widgetOffset.dx,
                top: value.widgetOffset.dy,
                child: VSNode(
                  data: value,
                ),
              );
            }),
            if (nodeDataProvider.contextMenuOffset != null)
              Positioned(
                left: nodeDataProvider.contextMenuOffset!.offset.dx,
                top: nodeDataProvider.contextMenuOffset!.offset.dy,
                child: VSContextMenu(
                  nodeBuilders: provider.nodeBuildersMap,
                ),
              ),
          ],
        );
      }),
    );
  }
}
