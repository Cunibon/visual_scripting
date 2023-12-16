import 'package:flutter/material.dart';

class FinalWidgetOffset {
  FinalWidgetOffset({
    required this.offset,
    required this.child,
  });
  Offset offset;
  Widget child;
}

class TwoDimensinalCoordinatChildBuilderDelegate
    extends TwoDimensionalChildBuilderDelegate {
  TwoDimensinalCoordinatChildBuilderDelegate({
    super.maxXIndex,
    super.maxYIndex,
    required this.gridSize,
    required super.builder,
    super.addRepaintBoundaries,
    super.addAutomaticKeepAlives,
  });

  final int gridSize;
}
