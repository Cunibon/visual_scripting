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
          if (!builderMap.containsKey(builder.name)) {
            builderMap[builder.name] = subMap;
          } else {
            throw FormatException(
              "There are 2 or more subgroups with the name ${builder.name}. There can only be one on the same level",
            );
          }
        } else {
          final instance = builder(Offset.zero, null) as VSNodeData;
          if (!_nodes.containsKey(instance.title)) {
            final inputNames = instance.inputData.map((e) => e.name);
            if (inputNames.length != inputNames.toSet().length) {
              throw FormatException(
                "There are 2 or more Inputs in the node ${instance.title} with the same name. There can only be one",
              );
            }
            _nodes[instance.title] = instance;
          } else {
            throw FormatException(
              "There are 2 or more nodes with the name ${instance.title}. There can only be one",
            );
          }

          builderMap[instance.title] = builder;
        }
      }
    }

    findNodes(nodeBuilders, nodeBuildersMap);
  }

  final Map<String, VSNodeData> _nodes = {};
  final Map<String, dynamic> nodeBuildersMap = {};
}
