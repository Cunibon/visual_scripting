import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/vs_context_menu.dart';
import 'package:visual_scripting/VSNode/vs_node.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';

class VSNodeView extends StatelessWidget {
  const VSNodeView({
    required this.nodeBuilders,
    this.contextMenuOverride,
    this.provider,
    super.key,
  });

  final Map<String, dynamic> nodeBuilders;
  final VSNodeDataProvider? provider;
  final Widget? contextMenuOverride;

  @override
  Widget build(BuildContext context) {
    final vsNodeDataProvider = provider ?? VSNodeDataProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: vsNodeDataProvider),
      ],
      child: Builder(builder: (context) {
        final nodeDataProvider = context.watch<VSNodeDataProvider>();

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (details) => nodeDataProvider.closeContextMenu(),
          onSecondaryTapUp: (details) {
            nodeDataProvider.openContextMenu(
              position: details.globalPosition,
            );
          },
          child: Stack(
            children: [
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
                  child: contextMenuOverride ??
                      VSContextMenu(
                        nodeBuilders: nodeBuilders,
                      ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
