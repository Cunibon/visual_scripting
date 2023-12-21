import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';

class ContextMenuContext {
  ContextMenuContext({
    required this.offset,
    this.reference,
  });

  Offset offset;
  VSOutputData? reference;
}

class VSNodeDataProvider extends ChangeNotifier {
  Map<String, VSNodeData> _data = {};

  Map<String, VSNodeData> get data => _data;

  void setData(VSNodeData nodeData) async {
    _data = Map.from(_data..[nodeData.id] = nodeData);
    notifyListeners();
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

  void createNode(VSNodeData Function(Offset, VSOutputData?) builder) {
    setData(
      builder(
        _contextMenuOffset!.offset,
        _contextMenuOffset!.reference,
      ),
    );
  }
}
