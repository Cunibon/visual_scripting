import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_context_menu.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node.dart';

class VSNodeView extends StatelessWidget {
  const VSNodeView({
    required this.provider,
    this.contextMenuBuilder,
    this.nodeBuilder,
    this.nodeTitleBuilder,
    super.key,
  });

  ///The provider that will be used to controll the UI
  final VSNodeDataProvider provider;

  ///Can be used to take control over the building of the nodes
  final Widget Function(
    BuildContext context,
    VSNodeData data,
  )? nodeBuilder;

  ///Can be used to take control over the building of the context menu
  final Widget Function(
    BuildContext context,
    Map<String, dynamic> nodeBuildersMap,
  )? contextMenuBuilder;

  ///Can be used to take control over the building of the nodes titles
  final Widget Function(
    BuildContext context,
    VSNodeData nodeData,
  )? nodeTitleBuilder;

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
                child: nodeBuilder?.call(context, value) ??
                    VSNode(
                      data: value,
                      nodeTitleBuilder: nodeTitleBuilder,
                    ),
              );
            }),
            if (nodeDataProvider.contextMenuContext != null)
              Positioned(
                left: nodeDataProvider.contextMenuContext!.offset.dx,
                top: nodeDataProvider.contextMenuContext!.offset.dy,
                child: contextMenuBuilder?.call(
                        context, provider.nodeBuildersMap) ??
                    VSContextMenu(
                      nodeBuilders: provider.nodeBuildersMap,
                    ),
              ),
          ],
        );
      }),
    );
  }
}
