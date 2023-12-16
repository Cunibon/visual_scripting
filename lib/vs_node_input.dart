import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/coordinate_view_provider.dart';
import 'package:visual_scripting/line_drawer.dart';

class VSNodeInput extends StatelessWidget {
  const VSNodeInput({
    required this.title,
    required this.data,
    required this.scrollOffset,
    super.key,
  });

  final String title;
  final VSNodeData data;
  final Offset scrollOffset;

  Offset? updatePosition(Offset? newPosition) {
    if (newPosition == null) return null;

    newPosition = Offset(
      newPosition.dx - data.widgetOffset.dx,
      newPosition.dy - data.widgetOffset.dy,
    );
    return newPosition;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPaint(
            painter: LinePainter(
              const Offset(5, 5),
              updatePosition(
                data.inputs[title]?.widgetOffset,
              ),
            ),
            child: DragTarget<VSNodeData>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 10,
                  width: 10,
                  color: Colors.cyan,
                );
              },
              onAccept: (inoput) {
                context.read<CoordinatProvider>().setData(
                      data..inputs[title] = inoput,
                    );
              },
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
