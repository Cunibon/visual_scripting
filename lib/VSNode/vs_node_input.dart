import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visual_scripting/VSNode/Data/vs_interface.dart';
import 'package:visual_scripting/VSNode/line_drawer.dart';
import 'package:visual_scripting/VSNode/vs_node_data_provider.dart';

const centerOffset = Offset(7.5, 7.5);

class VSNodeInput extends StatefulWidget {
  const VSNodeInput({
    required this.data,
    super.key,
  });

  final VSInputData data;

  @override
  State<VSNodeInput> createState() => _VSNodeInputState();
}

class _VSNodeInputState extends State<VSNodeInput> {
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

  Offset? updateLinePosition(VSOutputData? outputData) {
    if (outputData?.widgetOffset == null || widget.data.widgetOffset == null) {
      return null;
    }

    return outputData!.widgetOffset! +
        outputData.nodeData.widgetOffset -
        widget.data.nodeData.widgetOffset -
        widget.data.widgetOffset! +
        centerOffset;
  }

  void updateConnectedNode(VSOutputData? data) {
    widget.data.connectedNode = data;
    context.read<VSNodeDataProvider>().setData(
          widget.data.nodeData,
        );
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.data.connectedNode == null
        ? Icons.radio_button_unchecked
        : Icons.radio_button_checked;
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPaint(
            painter: LinePainter(
              centerOffset,
              updateLinePosition(
                widget.data.connectedNode,
              ),
            ),
            child: DragTarget<VSOutputData>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return GestureDetector(
                  onTap: () {
                    updateConnectedNode(null);
                  },
                  child: Icon(
                    icon,
                    key: _anchor,
                    color: widget.data.interfaceColor,
                    size: 15,
                  ),
                );
              },
              onAccept: (data) {
                updateConnectedNode(data);
              },
            ),
          ),
          Text(widget.data.name),
        ],
      ),
    );
  }
}
