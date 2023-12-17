import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_child_builder_delegate_wraper.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_view.dart';
import 'package:visual_scripting/coordinate_view_provider.dart';
import 'package:visual_scripting/vs_node.dart';

class CoordinatView extends StatelessWidget {
  const CoordinatView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontal = ScrollController();
    final ScrollController vertical = ScrollController();

    return Builder(
      builder: (context) {
        final coordinatProvider = context.watch<CoordinateProvider>();

        final coordsDelegateWraper =
            TwoDimensinalCoordinatChildBuilderDelegateWraper(
          xCellCount: 5,
          yCellCount: 5,
          cellSize: 1000,
          gridBuilder: (context, gridPosition) => Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(color: Colors.grey),
            ),
            height: 1000,
            width: 1000,
          ),
          widgets: coordinatProvider.data.values.map((value) {
            return WidgetOffset(
              offset: value.widgetOffset,
              child: Draggable(
                onDragEnd: (details) {
                  coordinatProvider.setData(
                    value..widgetOffset = details.offset,
                  );
                },
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 100,
                  width: 100,
                  child: const Icon(Icons.directions_run),
                ),
                child: VSNode(
                  data: value,
                  scrollOffset: const Offset(0, 0),
                ),
              ),
            );
          }).toList(),
        );

        return TwoDimensionalCoordinatView(
          horizontalDetails:
              ScrollableDetails.horizontal(controller: horizontal),
          verticalDetails: ScrollableDetails.vertical(controller: vertical),
          diagonalDragBehavior: DiagonalDragBehavior.free,
          delegate: coordsDelegateWraper.delegate,
        );
      },
    );
  }
}
