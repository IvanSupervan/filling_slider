import 'package:flutter/material.dart';

enum FillingSliderDirection { vertical, horizontal }

class FillingSlider extends StatefulWidget {
  /// Creates a vertical slider in IOS settings style.
  final double initialCount;
  final Function onChange;
  final FillingSliderDirection direction;
  final double height;
  final double width;
  final Color background;
  final Color activeBackground;
  final Widget child;
  FillingSlider(
      {Key key,
      this.initialCount = 1.0,
      this.onChange,
      this.direction = FillingSliderDirection.vertical,
      this.background = const Color.fromRGBO(46, 45, 36, 0.5),
      this.activeBackground = const Color.fromRGBO(215, 216, 218, 0.3),
      this.child,
      this.width = 80,
      this.height = 200})
      : super(key: key);
  @override
  _FillingSliderState createState() => _FillingSliderState();
}

class _FillingSliderState extends State<FillingSlider> {
  double stateY;

  @override
  void initState() {
    stateY = widget.initialCount;
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return widget.direction == FillingSliderDirection.vertical
        ? getVertical()
        : getHorizontal();
  }

  void updateData(double position) {
    double currentY = double.parse((1 -
            (position /
                (widget.direction == FillingSliderDirection.horizontal
                    ? widget.width
                    : widget.height)))
        .toStringAsFixed(2));
    if (currentY > 1) {
      currentY = 1;
    } else if (currentY < 0) {
      currentY = 0;
    }
    if (widget.onChange != null) {
      widget.onChange(currentY, stateY);
    }
    setState(() {
      stateY = currentY;
    });
  }

  Widget getHorizontal() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        updateData(details.localPosition.dx);
      },
      onTapUp: (details) {
        updateData(details.localPosition.dx);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.background,
                  widget.activeBackground
                ],
                stops: [
                  1 - stateY,
                  0,
                ]),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.child == null ? Container() : widget.child,
            Padding(padding: EdgeInsets.only(right: 12))
          ],
        ),
      ),
    );
  }

  Widget getVertical() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        updateData(details.localPosition.dy);
      },
      onTapUp: (details) {
        updateData(details.localPosition.dy);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.background,
                  widget.activeBackground
                ],
                stops: [
                  1 - stateY,
                  0,
                ]),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.child == null ? Container() : widget.child,
            Padding(padding: EdgeInsets.only(bottom: 12))
          ],
        ),
      ),
    );
  }
}
