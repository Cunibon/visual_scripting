import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_child_builder_delegate_wraper.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_view.dart';
import 'package:visual_scripting/node_data_provider.dart';
import 'package:visual_scripting/vs_node.dart';

class CoordinatView extends StatelessWidget {
  const CoordinatView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController horizontal = ScrollController();
    final ScrollController vertical = ScrollController();

    return Builder(
      builder: (context) {
        final nodeDataProvider = context.watch<NodeDataProvider>();

        final coordsDelegateWraper =
            TwoDimensinalCoordinatChildBuilderDelegateWraper(
          xCellCount: 5,
          yCellCount: 5,
          cellSize: 1000,
          gridBuilder: (context, gridPosition) => Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.blueGrey),
            ),
            height: 1000,
            width: 1000,
          ),
          widgets: nodeDataProvider.data.values.map((value) {
            return WidgetOffset(
              offset: value.widgetOffset,
              child: VSNode(
                data: value,
                scrollOffset: const Offset(0, 0),
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
