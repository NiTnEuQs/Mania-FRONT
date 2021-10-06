import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class Bloc extends StatelessWidget {
  Bloc({Key key, this.child, this.padding, this.shadow});

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
        boxShadow: shadow ?? false
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      padding: padding ?? const EdgeInsets.all(8.0),
      child: child,
    );
  }
}
