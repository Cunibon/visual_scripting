import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';

enum SelectionMode { select, deselect }

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
  SelectionMode? mode;

  Offset? startPos;
  Offset? endPos;

  Offset? normalizedStartPos;
  Offset? normalizedEndPos;

  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener((input) {
      if (input.isControlPressed || input.isMetaPressed) {
        setState(() {
          mode = SelectionMode.select;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (startPos != null && endPos != null) {
      late double startPosX;
      late double startPosY;

      late double endPosX;
      late double endPosY;

      if (startPos!.dx < endPos!.dx) {
        startPosX = startPos!.dx;
        endPosX = endPos!.dx;
      } else {
        startPosX = endPos!.dx;
        endPosX = startPos!.dx;
      }

      if (startPos!.dy < endPos!.dy) {
        startPosY = startPos!.dy;
        endPosY = endPos!.dy;
      } else {
        startPosY = endPos!.dy;
        endPosY = startPos!.dy;
      }

      normalizedStartPos = Offset(startPosX, startPosY);
      normalizedEndPos = Offset(endPosX, endPosY);

      children.add(Positioned(
        left: startPosX,
        top: startPosY,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(
              115,
              0,
              204,
              255,
            ),
          ),
          width: endPosX - startPosX,
          height: endPosY - startPosY,
        ),
      ));
    }

    children.add(widget.child);

    return mode == null
        ? widget.child
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              setState(
                () => startPos = widget.provider.applyViewPortTransfrom(
                  details.globalPosition,
                ),
              );
            },
            onPanUpdate: (details) {
              setState(
                () => endPos = widget.provider.applyViewPortTransfrom(
                  details.globalPosition,
                ),
              );
            },
            onPanEnd: (details) {
              widget.provider.addFromSelectioArea(
                normalizedStartPos!,
                normalizedEndPos!,
              );

              normalizedStartPos = null;
              normalizedEndPos = null;

              setState(
                () {
                  mode = null;
                  startPos = null;
                  endPos = null;
                },
              );
            },
            child: Stack(
              children: children,
            ),
          );
  }
}
