import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_serialization_manager.dart';
import 'package:visual_scripting/VSNode/SpecialNodes/vs_end_node.dart';

class VSNodeManager {
  VSNodeManager({
    required List<dynamic> nodeBuilders,
    String? serializedNodes,
  }) {
    serializationManager = VSNodeSerializationManager(
      nodeBuilders: nodeBuilders,
    );

    if (serializedNodes != null) {
      data = serializationManager.deserializeNodes(serializedNodes);
    }
  }

  late VSNodeSerializationManager serializationManager;
  Map<String, dynamic> get nodeBuildersMap =>
      serializationManager.contextNodeBuilders;

  Iterable<VSEndNode> get getEndNodes => data.values.whereType<VSEndNode>();

  Map<String, VSNodeData> data = {};

  String serializeNodes() {
    return serializationManager.serializeNodes(data);
  }
}
