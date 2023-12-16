import 'package:flutter/material.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_child_builder_delegate.dart';

class WidgetOffset {
  WidgetOffset({
    required this.offset,
    required this.child,
  });
  Offset offset;
  final Widget child;
}

class TwoDimensinalCoordinatChildBuilderDelegateWraper {
  TwoDimensinalCoordinatChildBuilderDelegateWraper({
    required int xCellCount,
    required int yCellCount,
    required int cellSize,
    required TwoDimensionalIndexedWidgetBuilder gridBuilder,
    required this.widgets,
    bool addRepaintBoundaries = true,
    bool addAutomaticKeepAlives = true,
  }) {
    for (var value in widgets) {
      final x = (value.offset.dx / cellSize).floor();
      final y = (value.offset.dy / cellSize).floor();

      widgetPositions
          .putIfAbsent(ChildVicinity(xIndex: x, yIndex: y), () => [])
          .add(
            WidgetOffset(
              offset: Offset(value.offset.dx - x * cellSize,
                  value.offset.dy - y * cellSize),
              child: value.child,
            ),
          );
    }

    delegate = TwoDimensinalCoordinatChildBuilderDelegate(
      maxXIndex: xCellCount - 1,
      maxYIndex: yCellCount - 1,
      gridSize: cellSize,
      builder: (context, gridPosition) {
        late Widget widget;
        if (widgetPositions.containsKey(gridPosition)) {
          final widgets = widgetPositions[gridPosition]!;
          widget = Stack(
            children: [
              gridBuilder(context, gridPosition)!,
              ...widgets.map(
                (e) => Positioned(
                  left: e.offset.dx,
                  top: e.offset.dy,
                  child: e.child,
                ),
              ),
            ],
          );
        } else {
          widget = gridBuilder(context, gridPosition)!;
        }

        return widget;
      },
      addRepaintBoundaries: addRepaintBoundaries,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
    );
  }

  final List<WidgetOffset> widgets;
  final Map<ChildVicinity, List<WidgetOffset>> widgetPositions = {};
  late TwoDimensinalCoordinatChildBuilderDelegate delegate;
}
