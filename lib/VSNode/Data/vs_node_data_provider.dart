import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_manager.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_view.dart';

typedef VSNodeDataBuilder = VSNodeData Function(Offset, VSOutputData?);

///Small data class to keep track of where the context menu is in 2D space
///
///Also knows if it was opend through a reference
class ContextMenuContext {
  ContextMenuContext({
    required this.offset,
    this.reference,
  });

  Offset offset;
  VSOutputData? reference;
}

class VSNodeDataProvider extends ChangeNotifier {
  ///Wraps VSNodeManager to allow UI interaction and updates
  VSNodeDataProvider({
    required List<dynamic> nodeBuilders,
    String? serializedNodes,
  }) {
    nodeManger = VSNodeManager(
      nodeBuilders: nodeBuilders,
      serializedNodes: serializedNodes,
    );
  }

  late VSNodeManager nodeManger;
  Map<String, dynamic> get nodeBuildersMap => nodeManger.nodeBuildersMap;
  Map<String, VSNodeData> get data => nodeManger.data;

  ///Updates an existing node or creates it
  ///
  ///Notifies listeners to this provider
  void updateOrCreateNodes(List<VSNodeData> nodeDatas) async {
    nodeManger.updateOrCreateNodes(nodeDatas);
    notifyListeners();
  }

  void moveNode(VSNodeData nodeData, Offset offset) {
    final movedOffset = applyViewPortTransfrom(offset) - nodeData.widgetOffset;

    final List<VSNodeData> modifiedNodes = [];

    if (selectedNodes.contains(nodeData.id)) {
      for (final nodeId in selectedNodes) {
        final currentNode = data[nodeId]!;
        modifiedNodes.add(
          currentNode..widgetOffset = currentNode.widgetOffset + movedOffset,
        );
      }
    } else {
      modifiedNodes.add(
        nodeData..widgetOffset = nodeData.widgetOffset + movedOffset,
      );
    }

    updateOrCreateNodes(modifiedNodes);
  }

  ///Removes a node
  ///
  ///Notifies listeners to this provider
  void removeNode(VSNodeData nodeData) async {
    nodeManger.removeNode(nodeData);
    notifyListeners();
  }

  ///Creates a node based on the builder and the current [_contextMenuContext]
  ///
  ///Notifies listeners to this provider
  void createNodeFromContext(VSNodeDataBuilder builder) {
    updateOrCreateNodes(
      [
        builder(
          _contextMenuContext!.offset,
          _contextMenuContext!.reference,
        )
      ],
    );
  }

  Set<String> _selectedNodes = {};
  Set<String> get selectedNodes => _selectedNodes;

  set selectedNodes(Set<String> data) {
    _selectedNodes = Set.from(data);
    notifyListeners();
  }

  void addSelectedNodes(Iterable<String> data) {
    selectedNodes = selectedNodes..addAll(data);
  }

  void addFromSelectioArea(Offset start, Offset end) {
    final Set<String> selected = {};
    for (final node in nodeManger.data.values) {
      final pos = node.widgetOffset;
      if (pos.dy > start.dy &&
          pos.dx > start.dx &&
          pos.dy < end.dy &&
          pos.dx < end.dx) {
        selected.add(node.id);
      }
    }
    addSelectedNodes(selected);
  }

  ContextMenuContext? _contextMenuContext;
  ContextMenuContext? get contextMenuContext => _contextMenuContext;

  ///Used to offset the UI by a given value
  ///
  ///Usefull if you want to wrap [VSNodeView] in an [InteractiveViewer] or the sorts,
  ///to assure context menu and node interactions work as planned
  Offset viewportOffset = Offset.zero;

  ///Used to offset the UI by a given value
  ///
  ///Usefull if you want to wrap [VSNodeView] in an [InteractiveViewer] or the sorts,
  ///to assure context menu and node interactions work as planned
  double viewportScale = 1;

  ///Helper function to apply [viewportOffset] and [viewportScale] to a Offset
  Offset applyViewPortTransfrom(Offset inital) =>
      (inital - viewportOffset) * viewportScale;

  ///Opens the context menu at a given postion
  ///
  ///If the context menu was opened through a reference it will also be passed
  void openContextMenu({
    required Offset position,
    VSOutputData? outputData,
  }) {
    _contextMenuContext = ContextMenuContext(
      offset: applyViewPortTransfrom(position),
      reference: outputData,
    );
    notifyListeners();
  }

  ///Closes the context menu
  void closeContextMenu() {
    _contextMenuContext = null;
    notifyListeners();
  }
}
