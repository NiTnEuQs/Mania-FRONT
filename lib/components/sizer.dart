import 'package:flutter/material.dart';

class Sizer extends StatelessWidget {
  const Sizer(this.child, {this.width, this.height, this.padding, this.horizontalAlignment, this.verticalAlignment});

  final Widget child;
  final SizeGeometry? width;
  final SizeGeometry? height;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? horizontalAlignment;
  final MainAxisAlignment? verticalAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: horizontalAlignment ?? MainAxisAlignment.start,
        mainAxisSize: width == SizeGeometry.matchParent ? MainAxisSize.max : MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: verticalAlignment ?? MainAxisAlignment.start,
            mainAxisSize: height == SizeGeometry.matchParent ? MainAxisSize.max : MainAxisSize.min,
            children: <Widget>[child],
          ),
        ],
      ),
    );
  }
}

enum SizeGeometry {
  wrapContent,
  matchParent,
}
