import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_subgroup.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_end_node.dart';

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
  }) {
    void findNodes(
      List<dynamic> builders,
      Map<String, dynamic> builderMap,
    ) {
      for (final builder in builders) {
        if (builder is VSSubgroup) {
          final Map<String, dynamic> subMap = {};
          findNodes(builder.subgroup, subMap);
          builderMap[builder.name] = subMap;
        } else {
          final instance = builder(Offset.zero, null) as VSNodeData;
          _nodes[instance.title] = instance;
          builderMap[instance.title] = builder;
        }
      }
    }

    findNodes(nodeBuilders, nodeBuildersMap);
  }

  final Map<String, VSNodeData> _nodes = {};
  final Map<String, dynamic> nodeBuildersMap = {};

  Iterable<VSEndNode> get getEndNodes => _data.values.whereType<VSEndNode>();

  Map<String, VSNodeData> _data = {};
  Map<String, VSNodeData> get data => _data;

  void setData(VSNodeData nodeData) async {
    _data = Map.from(_data..[nodeData.id] = nodeData);
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
