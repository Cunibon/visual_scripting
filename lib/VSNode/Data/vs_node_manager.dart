import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_serialization_manager.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_output_node.dart';

class VSNodeManager {
  ///Holds all relevant node data
  ///
  ///Handles interactions with the data
  ///
  ///Creates an instance of VSNodeSerializationManager to handle serializations
  VSNodeManager({
    required List<dynamic> nodeBuilders,
    String? serializedNodes,
  }) {
    serializationManager = VSNodeSerializationManager(
      nodeBuilders: nodeBuilders,
    );

    if (serializedNodes != null) {
      _data = serializationManager.deserializeNodes(serializedNodes);
    }
  }

  late VSNodeSerializationManager serializationManager;
  Map<String, dynamic> get nodeBuildersMap =>
      serializationManager.contextNodeBuilders;

  ///Returns all output nodes in the current node data
  Iterable<VSOutputNode> get getOutputNodes =>
      _data.values.whereType<VSOutputNode>();

  Map<String, VSNodeData> _data = {};

  ///Returns a copy of the current node data
  Map<String, VSNodeData> get data => Map.from(_data);

  ///Calls serializationManager.serializeNodes with the current node data and returns a String
  String serializeNodes() {
    return serializationManager.serializeNodes(_data);
  }

  ///Updates or Creates a node
  void updateOrCreateNodes(List<VSNodeData> nodeDatas) async {
    for (final node in nodeDatas) {
      _data[node.id] = node;
    }
    _data = Map.from(_data);
  }

  ///Removes a node and clears all references
  void removeNode(VSNodeData nodeData) async {
    _data = Map.from(_data..remove(nodeData.id));
    for (final node in _data.values) {
      for (final input in node.inputData) {
        if (input.connectedNode?.nodeData == nodeData) {
          input.connectedNode = null;
        }
      }
    }
  }
}
