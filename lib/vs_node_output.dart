import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/line_drawer.dart';
import 'package:visual_scripting/node_data_provider.dart';

class VSNodeOutput extends StatefulWidget {
  const VSNodeOutput({
    required this.data,
    required this.scrollOffset,
    super.key,
  });

  final VSOutputData data;
  final Offset scrollOffset;

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

    context.read<NodeDataProvider>().setData(widget.data.nodeData);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      findWidgetPosition();
    });
  }

  void updateLinePosition(Offset newPosition) {
    newPosition = newPosition +
        widget.scrollOffset -
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
                context.read<NodeDataProvider>().setData(
                      VSNodeData(
                        title: "New Node",
                        widgetOffset: offset,
                        inputData: [
                          VSInputData(
                            name: "input",
                            connectedNode: widget.data,
                          )
                        ],
                        outputData: [
                          VSOutputData(name: "input"),
                        ],
                      ),
                    );
              },
              feedback: Container(
                width: 10,
                height: 10,
                color: Colors.green,
              ),
              child: Container(
                key: _anchor,
                width: 10,
                height: 10,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
