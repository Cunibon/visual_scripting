import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_manager.dart';

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
  void updateOrCreateNode(VSNodeData nodeData) async {
    nodeManger.updateOrCreateNode(nodeData);
    notifyListeners();
  }

  ///Removes a node
  ///
  ///Notifies listeners to this provider
  void removeNode(VSNodeData nodeData) async {
    nodeManger.removeNode(nodeData);
    notifyListeners();
  }

  ///Creates a node based on the builder and the current contextMenu
  ///
  ///Notifies listeners to this provider
  void createNodeFromContext(VSNodeDataBuilder builder) {
    updateOrCreateNode(
      builder(
        _contextMenuContext!.offset,
        _contextMenuContext!.reference,
      ),
    );
  }

  ContextMenuContext? _contextMenuContext;
  ContextMenuContext? get contextMenuContext => _contextMenuContext;

  ///Opens the context menu at a given postion
  ///
  ///If the context menu was opened through a reference it will also be passed
  void openContextMenu({
    required Offset position,
    VSOutputData? outputData,
  }) {
    _contextMenuContext = ContextMenuContext(
      offset: position,
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
