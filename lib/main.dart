import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/vs_node_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 46, 46)),
      home: const Scaffold(
        body: VSNodeView(),
      ),
    );
  }
}
