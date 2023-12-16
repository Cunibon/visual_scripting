import 'package:flutter/material.dart';
import 'package:visual_scripting/coordinate_view_provider.dart';
import 'package:visual_scripting/line_drawer.dart';

class VSNodeOutput extends StatefulWidget {
  const VSNodeOutput({
    required this.title,
    required this.data,
    required this.scrollOffset,
    super.key,
  });

  final String title;
  final VSNodeData data;
  final Offset scrollOffset;

  @override
  State<VSNodeOutput> createState() => _VSNodeOutputState();
}

class _VSNodeOutputState extends State<VSNodeOutput> {
  Offset? dragPos;

  void updatePosition(Offset newPosition) {
    newPosition = Offset(
      (newPosition.dx + widget.scrollOffset.dx) -
          widget.data.widgetOffset.dx -
          100,
      (newPosition.dy + widget.scrollOffset.dy) -
          widget.data.widgetOffset.dy -
          35,
    );
    setState(() => dragPos = newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          CustomPaint(
            painter: LinePainter(const Offset(5, 5), dragPos),
            child: Draggable<VSNodeData>(
              data: widget.data,
              onDragUpdate: (details) => updatePosition(details.localPosition),
              onDragEnd: (details) => setState(() {
                dragPos = null;
              }),
              feedback: Container(
                width: 10,
                height: 10,
                color: Colors.green,
              ),
              child: Container(
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
