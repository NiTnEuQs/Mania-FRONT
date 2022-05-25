import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/custom/base_stateless_widget.dart';

class RoundedContainer extends BaseStatelessWidget {
  RoundedContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.splashColor,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  RoundedContainer.size({
    Key? key,
    Widget? child,
    double? size,
    double? radius,
    Color? color,
    Color? splashColor,
    EdgeInsetsGeometry? padding,
    VoidCallback? onPressed,
  }) : this(
          key: key,
          child: child,
          width: size,
          height: size,
          radius: radius,
          color: color,
          splashColor: splashColor,
          padding: padding,
          onPressed: onPressed,
        );

  RoundedContainer.circle({
    Key? key,
    Widget? child,
    double size = 50,
    Color? color,
    Color? splashColor,
    EdgeInsetsGeometry? padding,
    VoidCallback? onPressed,
  }) : this.size(
          key: key,
          child: child,
          size: size,
          radius: size / 2,
          color: color,
          splashColor: splashColor,
          padding: padding,
          onPressed: onPressed,
        );

  final Widget? child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 25)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 25),
          splashColor: splashColor,
          onTap: onPressed,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
