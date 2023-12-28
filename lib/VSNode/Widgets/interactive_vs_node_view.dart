import 'package:flutter/material.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data.dart';
import 'package:visual_scripting/VSNode/Data/vs_node_data_provider.dart';
import 'package:visual_scripting/VSNode/Widgets/vs_node_view.dart';

class InteractiveVSNodeView extends StatefulWidget {
  const InteractiveVSNodeView({
    super.key,
    this.controller,
    this.width,
    this.height,
    this.contextMenuBuilder,
    this.nodeBuilder,
    this.nodeTitleBuilder,
    required this.nodeDataProvider,
  });

  ///TransformationController used by the [InteractiveViewer] widget
  final TransformationController? controller;

  ///The provider that will be used to controll the UI
  final VSNodeDataProvider nodeDataProvider;

  final double? width;
  final double? height;

  ///Can be used to take control over the building of the nodes
  final Widget Function(
    BuildContext context,
    VSNodeData data,
  )? nodeBuilder;

  ///Can be used to take control over the building of the context menu
  final Widget Function(
    BuildContext context,
    Map<String, dynamic> nodeBuildersMap,
  )? contextMenuBuilder;

  ///Can be used to take control over the building of the nodes titles
  final Widget Function(
    BuildContext context,
    VSNodeData nodeData,
  )? nodeTitleBuilder;

  @override
  State<InteractiveVSNodeView> createState() => _InteractiveVSNodeViewState();
}

class _InteractiveVSNodeViewState extends State<InteractiveVSNodeView> {
  late TransformationController controller;
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    width = widget.width ?? screenSize.width;
    height = widget.height ?? screenSize.width;

    //Needs to be done with a listener to assure inertia doesnt messup the offset
    controller.addListener(
      () {
        final scale = 1 / controller.value.getMaxScaleOnAxis();
        widget.nodeDataProvider.viewportScale = scale;

        widget.nodeDataProvider.viewportOffset = Offset(
          controller.value.getTranslation().x,
          controller.value.getTranslation().y,
        );
      },
    );

    return InteractiveViewer(
      maxScale: 2,
      minScale: 0.01,
      constrained: false,
      transformationController: controller,
      child: SizedBox(
        width: width,
        height: height,
        child: VSNodeView(
          nodeDataProvider: widget.nodeDataProvider,
          contextMenuBuilder: widget.contextMenuBuilder,
          nodeBuilder: widget.nodeBuilder,
          nodeTitleBuilder: widget.nodeTitleBuilder,
        ),
      ),
    );
  }
}
