import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_view.dart';

enum SelectionMode { select, deselect }

class VSSelectionArea extends StatefulWidget {
  ///The base selection area
  ///
  ///Used inside [VSNodeView] to add a selction area to the node view
  ///
  ///Hold "Ctrl" to select items and "Shift" to unselect
  const VSSelectionArea({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<VSSelectionArea> createState() => _VSSelectionAreaState();
}

class _VSSelectionAreaState extends State<VSSelectionArea> {
  //Current selection mode
  //If null no selection mode is active
  SelectionMode? mode;

  //Raw input as delivered by  user
  Offset? startPos;
  Offset? endPos;

  //Inputs normalized to always have smalest values as top left and biggest as bottom right
  Offset? topLeftPos;
  Offset? bottomRightPos;

  late VSNodeDataProvider provider;

  @override
  void initState() {
    super.initState();

    provider = context.read<VSNodeDataProvider>();
    RawKeyboard.instance.addListener(handleKeyInput);
  }

  @override
  void dispose() {
    super.dispose();
    RawKeyboard.instance.removeListener(handleKeyInput);
  }

  ///Takes keyboard input and sets [mode] accordingly
  void handleKeyInput(input) {
    SelectionMode? newMode;
    if (input.isControlPressed || input.isMetaPressed) {
      newMode = SelectionMode.select;
    } else if (input.isShiftPressed) {
      newMode = SelectionMode.deselect;
    }
    setState(() {
      mode = newMode;
    });
  }

  ///Takes user input and sets [topLeftPos] an [bottomRightPos] accordingly
  void setNormedPositions() {
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

    topLeftPos = Offset(startPosX, startPosY);
    bottomRightPos = Offset(endPosX, endPosY);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (startPos != null && endPos != null) {
      setNormedPositions();

      children.add(
        Positioned(
          left: topLeftPos!.dx,
          top: topLeftPos!.dy,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                115,
                0,
                204,
                255,
              ),
            ),
            width: bottomRightPos!.dx - topLeftPos!.dx,
            height: bottomRightPos!.dy - topLeftPos!.dy,
          ),
        ),
      );
    }

    children.add(widget.child);

    return mode == null
        ? widget.child
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details) {
              setState(
                () => startPos = provider.applyViewPortTransfrom(
                  details.globalPosition,
                ),
              );
            },
            onPanUpdate: (details) {
              setState(
                () => endPos = provider.applyViewPortTransfrom(
                  details.globalPosition,
                ),
              );
            },
            onPanEnd: (details) {
              final nodes = provider
                  .findNodesInsideSelectionArea(
                    topLeftPos!,
                    bottomRightPos!,
                  )
                  .map((e) => e.id);

              switch (mode) {
                case SelectionMode.select:
                  provider.addSelectedNodes(nodes);
                  break;
                case SelectionMode.deselect:
                  provider.removeSelectedNodes(nodes);
                  break;
                default:
              }

              setState(
                () {
                  topLeftPos = null;
                  bottomRightPos = null;
                  startPos = null;
                  endPos = null;
                  mode = null;
                },
              );
            },
            child: Stack(
              children: children,
            ),
          );
  }
}
