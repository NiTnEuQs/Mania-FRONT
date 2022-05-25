import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/full_screen_scroll_view.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/custom/base_stateless_widget.dart';

class Background extends BaseStatelessWidget {
  Background({
    Key? key,
    this.child,
    this.borderRadius,
    this.padding,
    this.margin,
    this.shouldCountBar,
    this.scrollViewMargin,
    this.fullscreenScrollView,
  }) : super(key: key);

  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? scrollViewMargin;
  final BorderRadiusGeometry? borderRadius;
  final bool? shouldCountBar;
  final bool? fullscreenScrollView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Ink(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/ic_background.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      padding: EdgeInsets.only(
        // top: padding?.top ?? 0 + MediaQuery.of(context).padding.top + ((hasBar ?? false) ? Dimens.appbarHeight : 0),
        top: (padding?.bottom ?? 0) + ((shouldCountBar ?? false) ? MediaQuery.of(context).padding.top : 0),
        // top: padding?.top ?? 0 + ((shouldCountBar ?? false) ? MediaQuery.of(context).padding.top : 0),
        bottom: padding?.bottom ?? 0,
        right: padding?.right ?? 0,
        left: padding?.left ?? 0,
      ),
      child: Container(
        // padding: padding,
        margin: margin,
        child: (fullscreenScrollView ?? false)
            ? FullScreenScrollView(
          margin: scrollViewMargin,
                child: child,
              )
            : child,
      ),
    );
  }
}

class BackgroundScaffold extends Background {
  BackgroundScaffold({
    Key? key,
    this.appBar,
    this.extendBodyBehindAppBar,
    this.extendBody,
    Widget? child,
    BorderRadiusGeometry? borderRadius,
    EdgeInsets? padding,
    bool? shouldCountBar,
    EdgeInsets? scrollViewMargin,
    bool? fullscreenScrollView,
  }) : super(
          key: key,
          child: child,
          borderRadius: borderRadius,
          padding: padding,
          shouldCountBar: shouldCountBar,
          scrollViewMargin: scrollViewMargin,
          fullscreenScrollView: fullscreenScrollView,
        );

  final ManiaBar? appBar;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? true,
      extendBody: extendBody ?? true,
      appBar: appBar,
      body: super.build(context, ref),
    );
  }
}
