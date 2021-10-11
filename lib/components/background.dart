import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class Background extends StatelessWidget {
  Background({Key? key, this.child, this.radius, this.hasBar});

  final Widget? child;
  final BorderRadiusGeometry? radius;
  final bool? hasBar;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ic_background.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        borderRadius: radius ?? BorderRadius.all(Radius.circular(0)),
      ),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top - ((hasBar ?? false) ? Dimens.appbarHeight : 0)),
      child: child,
    );
  }
}
