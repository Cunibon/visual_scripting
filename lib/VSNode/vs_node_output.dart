import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/line_drawer.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';

class VSNodeOutput extends StatefulWidget {
  const VSNodeOutput({
    required this.data,
    super.key,
  });

  final VSOutputData data;

  @override
  State<VSNodeOutput> createState() => _VSNodeOutputState();
}

class _VSNodeOutputState extends State<VSNodeOutput> {
  Offset? dragPos;
  final GlobalKey _anchor = GlobalKey();

  void findWidgetPosition() {
    RenderBox renderBox =
        _anchor.currentContext?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    widget.data.widgetOffset = position - widget.data.nodeData.widgetOffset;

    context.read<VSNodeDataProvider>().setData(widget.data.nodeData);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      findWidgetPosition();
    });
  }

  void updateLinePosition(Offset newPosition) {
    newPosition = newPosition -
        widget.data.nodeData.widgetOffset -
        widget.data.widgetOffset!;

    setState(() => dragPos = newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.data.name),
          CustomPaint(
            painter: LinePainter(const Offset(5, 5), dragPos),
            child: Draggable<VSOutputData>(
              data: widget.data,
              onDragUpdate: (details) =>
                  updateLinePosition(details.localPosition),
              onDragEnd: (details) => setState(() {
                dragPos = null;
              }),
              onDraggableCanceled: (velocity, offset) {
                context.read<VSNodeDataProvider>().openContextMenu(
                      position: offset,
                      outputData: widget.data,
                    );
              },
              feedback: const Icon(
                Icons.circle,
                color: Colors.green,
                size: 15,
              ),
              child: Icon(
                Icons.circle,
                key: _anchor,
                color: widget.data.interfaceColor,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
