import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_context_menu.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_title.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_selection_area.dart';

class VSNodeView extends StatelessWidget {
  ///The base node widget
  ///
  ///Display and interact with nodes to build node trees
  const VSNodeView({
    required this.nodeDataProvider,
    this.enableSelectionArea = true,
    this.contextMenuBuilder,
    this.nodeBuilder,
    this.nodeTitleBuilder,
    this.selectionAreaBuilder,
    super.key,
  });

  ///The provider that will be used to controll the UI
  final VSNodeDataProvider nodeDataProvider;

  final bool enableSelectionArea;

  ///Can be used to take control over the building of the nodes
  ///
  ///See [VSNode] for reference
  final Widget Function(
    BuildContext context,
    VSNodeData data,
  )? nodeBuilder;

  ///Can be used to take control over the building of the context menu
  ///
  ///See [VSContextMenu] for reference
  final Widget Function(
    BuildContext context,
    Map<String, dynamic> nodeBuildersMap,
  )? contextMenuBuilder;

  ///Can be used to take control over the building of the nodes titles
  ///
  ///See [VSNodeTitle] for reference
  final Widget Function(
    BuildContext context,
    VSNodeData nodeData,
  )? nodeTitleBuilder;

  ///Can be used to take control over the building of the selection area
  ///
  ///See [VSSelectionArea] for reference
  final Widget Function(
    BuildContext context,
    Widget view,
  )? selectionAreaBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: nodeDataProvider),
      ],
      child: Builder(
        builder: (context) {
          final nodeDataProvider = context.watch<VSNodeDataProvider>();

          final nodes = nodeDataProvider.data.values.map((value) {
            return Positioned(
              left: value.widgetOffset.dx,
              top: value.widgetOffset.dy,
              child: nodeBuilder?.call(
                    context,
                    value,
                  ) ??
                  VSNode(
                    key: ValueKey(value.id),
                    data: value,
                    nodeTitleBuilder: nodeTitleBuilder,
                  ),
            );
          });

          final view = Stack(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  nodeDataProvider.closeContextMenu();
                  nodeDataProvider.selectedNodes = {};
                },
                onSecondaryTapUp: (details) {
                  nodeDataProvider.openContextMenu(
                    position: details.globalPosition,
                  );
                },
              ),
              ...nodes,
              if (nodeDataProvider.contextMenuContext != null)
                Positioned(
                  left: nodeDataProvider.contextMenuContext!.offset.dx,
                  top: nodeDataProvider.contextMenuContext!.offset.dy,
                  child: contextMenuBuilder?.call(
                        context,
                        nodeDataProvider.nodeBuildersMap,
                      ) ??
                      VSContextMenu(
                        nodeBuilders: nodeDataProvider.nodeBuildersMap,
                      ),
                ),
            ],
          );

          if (enableSelectionArea) {
            return selectionAreaBuilder?.call(
                  context,
                  view,
                ) ??
                VSSelectionArea(
                  child: view,
                );
          } else {
            return view;
          }
        },
      ),
    );
  }
}
