import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_subgroup.dart';

class VSNodeSerializationManager {
  VSNodeSerializationManager({
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
}
