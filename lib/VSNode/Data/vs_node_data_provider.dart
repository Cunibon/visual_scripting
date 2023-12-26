import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_manager.dart';

typedef VSNodeDataBuilder = VSNodeData Function(Offset, VSOutputData?);

class ContextMenuContext {
  ContextMenuContext({
    required this.offset,
    this.reference,
  });

  Offset offset;
  VSOutputData? reference;
}

class VSNodeDataProvider extends ChangeNotifier {
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
  set data(Map<String, VSNodeData> data) => nodeManger.data = data;

  void setData(VSNodeData nodeData) async {
    data = Map.from(data..[nodeData.id] = nodeData);
    notifyListeners();
  }

  void removeNode(VSNodeData nodeData) async {
    nodeManger.data = Map.from(nodeManger.data..remove(nodeData.id));
    for (final node in nodeManger.data.values) {
      for (final input in node.inputData) {
        if (input.connectedNode?.nodeData == nodeData) {
          input.connectedNode = null;
        }
      }
    }
    notifyListeners();
  }

  void createNode(VSNodeDataBuilder builder) {
    setData(
      builder(
        _contextMenuOffset!.offset,
        _contextMenuOffset!.reference,
      ),
    );
  }

  ContextMenuContext? _contextMenuOffset;
  ContextMenuContext? get contextMenuOffset => _contextMenuOffset;

  void openContextMenu({
    required Offset position,
    VSOutputData? outputData,
  }) {
    _contextMenuOffset = ContextMenuContext(
      offset: position,
      reference: outputData,
    );
    notifyListeners();
  }

  void closeContextMenu() {
    _contextMenuOffset = null;
    notifyListeners();
  }
}
