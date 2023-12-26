import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';

class VSNodeTitle extends StatelessWidget {
  const VSNodeTitle({
    required this.data,
    super.key,
  });

  final VSNodeData data;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    titleController.text = data.title;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: titleController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: data.type,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 5,
              ),
            ),
            onChanged: (input) => data.title = input,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => context.read<VSNodeDataProvider>().removeNode(
                data,
              ),
          icon: const Icon(Icons.close),
          iconSize: 20,
        ),
      ],
    );
  }
}
