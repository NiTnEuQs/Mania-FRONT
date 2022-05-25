import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateless_widget.dart';

class FutureWidget extends BaseStatelessWidget {
  FutureWidget(
    this.snapshot, {
    Key? key,
    this.child,
    this.errorColor = Colors.white,
    this.keepDataOnLoading = true,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final Widget? child;
  final Color? errorColor;
  final bool keepDataOnLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (keepDataOnLoading) {
      if (snapshot.hasData) {
        return child ?? Container();
      } else if (snapshot.hasError) {
        return Center(
          child: ManiaText(
            trans(context)?.text_errorOccurred,
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } else {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: ManiaText(
            trans(context)?.text_errorOccurred,
          ),
        );
      } else {
        return child ?? Container();
      }
    }
  }
}
