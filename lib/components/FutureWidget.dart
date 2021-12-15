import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/whitetext.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget(
    this.snapshot, {
    Key? key,
    this.child,
    this.circleColor = Colors.white,
    this.errorColor = Colors.white,
    this.keepDataOnLoading = true,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final Widget? child;
  final Color? circleColor, errorColor;
  final bool keepDataOnLoading;

  @override
  Widget build(BuildContext context) {
    if (keepDataOnLoading) {
      if (snapshot.hasData) {
        return this.child ?? Container();
      } else if (snapshot.hasError) {
        return Center(
          child: WhiteText(
            trans(context)!.text_errorOccurred,
            color: errorColor,
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: circleColor,
          ),
        );
      }
    } else {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: circleColor,
          ),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: WhiteText(
            trans(context)!.text_errorOccurred,
            color: errorColor,
          ),
        );
      } else {
        return this.child ?? Container();
      }
    }
  }
}
