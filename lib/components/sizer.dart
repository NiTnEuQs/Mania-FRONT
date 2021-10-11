import 'package:flutter/material.dart';

class Sizer extends StatelessWidget {
  Sizer(this.child, {Key? key, this.width, this.height, this.padding, this.horizontalAlignment, this.verticalAlignment});

  final Widget child;
  final SizeGeometry? width, height;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? horizontalAlignment, verticalAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: horizontalAlignment ?? MainAxisAlignment.start,
        mainAxisSize: width == SizeGeometry.MATCH_PARENT ? MainAxisSize.max : MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: verticalAlignment ?? MainAxisAlignment.start,
            mainAxisSize: height == SizeGeometry.MATCH_PARENT ? MainAxisSize.max : MainAxisSize.min,
            children: <Widget>[child],
          ),
        ],
      ),
    );
  }
}

enum SizeGeometry {
  WRAP_CONTENT,
  MATCH_PARENT,
}
