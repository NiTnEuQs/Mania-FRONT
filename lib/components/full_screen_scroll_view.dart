import 'package:flutter/material.dart';

class FullScreenScrollView extends StatelessWidget {
  const FullScreenScrollView({this.child, this.margin});

  final Widget? child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - (margin?.top ?? 0) - (margin?.bottom ?? 0),
        width: MediaQuery.of(context).size.width - (margin?.left ?? 0) - (margin?.right ?? 0),
        margin: margin,
        child: child,
      ),
    );
  }
}
