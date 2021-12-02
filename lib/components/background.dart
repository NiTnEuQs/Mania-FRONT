import 'package:flutter/material.dart';
import 'package:mania/components/full_screen_scroll_view.dart';
import 'package:mania/components/mania_bar.dart';

class Background extends StatelessWidget {
  Background({Key? key, this.child, this.borderRadius, this.padding, this.margin, this.shouldCountBar, this.scrollViewMargin, this.fullscreenScrollView});

  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? scrollViewMargin;
  final BorderRadiusGeometry? borderRadius;
  final bool? shouldCountBar, fullscreenScrollView;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ic_background.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(0)),
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
                child: child,
                margin: scrollViewMargin,
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
    child,
    borderRadius,
    padding,
    shouldCountBar,
    scrollViewMargin,
    fullscreenScrollView,
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
  final bool? extendBody, extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? true,
      extendBody: extendBody ?? true,
      appBar: appBar,
      body: super.build(context),
    );
  }
}
