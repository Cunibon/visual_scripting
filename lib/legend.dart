import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_bool_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_double_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_dynamic_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_int_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_num_interface.dart';
import 'package:visual_scripting/VSNode/Data/StandardInterfaces/vs_string_interface.dart';

Map<String, Color> inputTypes = {
  "String": VSStringInputData(name: "legend").interfaceColor,
  "Int": VSIntInputData(name: "legend").interfaceColor,
  "Double": VSDoubleInputData(name: "legend").interfaceColor,
  "Num": VSNumInputData(name: "legend").interfaceColor,
  "Bool": VSBoolInputData(name: "legend").interfaceColor,
  "Dynamic": VSDynamicInputData(name: "legend").interfaceColor,
};

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    final entries = inputTypes.entries;

    for (final entry in entries) {
      widgets.add(
        Row(
          children: [
            Text(entry.key),
            Icon(
              Icons.circle,
              color: entry.value,
            ),
            if (entry != entries.last) const Divider(),
          ],
        ),
      );
    }

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: widgets,
      ),
    ));
  }
}
