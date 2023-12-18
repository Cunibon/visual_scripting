import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/coordinate_view.dart';
import 'package:visual_scripting/node_data_provider.dart';

void main() {
  final coordinatProvider = NodeDataProvider();

  coordinatProvider.setData(VSNodeData(
    title: "First Node",
    widgetOffset: const Offset(0, 0),
    inputData: [VSInputData(name: "input"), VSInputData(name: "input")],
    outputData: [VSOutputData(name: "input")],
  ));

  coordinatProvider.setData(VSNodeData(
    title: "Second Node",
    widgetOffset: const Offset(0, 0),
    inputData: [VSInputData(name: "input")],
    outputData: [VSOutputData(name: "input"), VSOutputData(name: "input")],
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
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46)),
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
