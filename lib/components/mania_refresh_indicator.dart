import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/custom/base_stateless_widget.dart';

class ManiaRefreshIndicator extends BaseStatelessWidget {
  ManiaRefreshIndicator({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Function() onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      onRefresh: () {
        onRefresh();
        return Future.value(null);
      },
      child: child,
    );
  }
}
