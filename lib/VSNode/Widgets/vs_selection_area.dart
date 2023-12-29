import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';

class VSSelectionArea extends StatefulWidget {
  const VSSelectionArea({
    required this.provider,
    required this.child,
    super.key,
  });

  final VSNodeDataProvider provider;

  final Widget child;

  @override
  State<VSSelectionArea> createState() => _VSSelectionAreaState();
}

class _VSSelectionAreaState extends State<VSSelectionArea> {
  Offset? startPos;
  Offset? endPos;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    if (startPos != null && endPos != null) {
      widgets.add(Positioned(
        left: startPos!.dx,
        top: startPos!.dy,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(
              115,
              0,
              204,
              255,
            ),
          ),
          width: endPos!.dx - startPos!.dx,
          height: endPos!.dy - startPos!.dy,
        ),
      ));
    }

    widgets.add(widget.child);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        setState(
          () => startPos = widget.provider.applyViewPortTransfrom(
            details.globalPosition,
          ),
        );
      },
      onPanUpdate: (details) {
        print("update");
        setState(
          () => endPos = widget.provider.applyViewPortTransfrom(
            details.globalPosition,
          ),
        );
      },
      onPanEnd: (details) {
        setState(
          () => startPos = null,
        );
      },
      child: Stack(
        children: widgets,
      ),
    );
  }
}
