import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visual_scripting/CoordinatView/two_dimensional_coordinat_child_builder_delegate.dart';

class RenderTwoDimensionalCoordinatViewport
    extends RenderTwoDimensionalViewport {
  RenderTwoDimensionalCoordinatViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width + cacheExtent;
    final double viewportHeight = viewportDimension.height + cacheExtent;
    final TwoDimensinalCoordinatChildBuilderDelegate builderDelegate =
        delegate as TwoDimensinalCoordinatChildBuilderDelegate;

    final int maxRowIndex = builderDelegate.maxYIndex!;
    final int maxColumnIndex = builderDelegate.maxXIndex!;

    final int leadingColumn =
        math.max((horizontalPixels / builderDelegate.gridSize).floor(), 0);
    final int leadingRow =
        math.max((verticalPixels / builderDelegate.gridSize).floor(), 0);
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / builderDelegate.gridSize).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / builderDelegate.gridSize).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset =
        (leadingColumn * builderDelegate.gridSize) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset =
          (leadingRow * builderDelegate.gridSize) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox child = buildOrObtainChildFor(vicinity)!;
        child.layout(constraints.loosen());

        // Subclasses only need to set the normalized layout offset. The super
        // class adjusts for reversed axes.
        parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);
        yLayoutOffset += builderDelegate.gridSize;
      }
      xLayoutOffset += builderDelegate.gridSize;
    }

    // Set the min and max scroll extents for each axis.
    final double verticalExtent = builderDelegate.gridSize * (maxRowIndex + 1);
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          verticalExtent - viewportDimension.height, 0.0, double.infinity),
    );
    final double horizontalExtent =
        builderDelegate.gridSize * (maxColumnIndex + 1);
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          horizontalExtent - viewportDimension.width, 0.0, double.infinity),
    );
    // Super class handles garbage collection too!
  }
}
