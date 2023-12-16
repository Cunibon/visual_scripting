import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/coordinate_view.dart';
import 'package:visual_scripting/coordinate_view_provider.dart';

void main() {
  final coordinatProvider = CoordinatProvider();

  coordinatProvider.setData(VSNodeData(
    title: "First Node",
    widgetOffset: const Offset(0, 0),
    inputs: {"input": null},
    outputs: {"output": null},
  ));

  coordinatProvider.setData(VSNodeData(
    title: "Second Node",
    widgetOffset: const Offset(0, 0),
    inputs: {"input": null},
    outputs: {"output": null},
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: coordinatProvider),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        // Mouse dragging enabled for this demo
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      home: const Scaffold(
        body: CoordinatView(),
      ),
    );
  }
}
