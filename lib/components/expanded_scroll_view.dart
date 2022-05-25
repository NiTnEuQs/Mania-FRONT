import 'package:flutter/material.dart';

class ExpandedScrollView extends StatelessWidget {
  const ExpandedScrollView({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
