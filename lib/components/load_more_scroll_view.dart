import 'package:flutter/material.dart';

class LoadMoreScrollView extends StatefulWidget {
  const LoadMoreScrollView({
    required this.child,
    this.onLoadMore,
  });

  final Widget? child;
  final Function()? onLoadMore;

  @override
  State<LoadMoreScrollView> createState() => _LoadMoreScrollViewState();
}

class _LoadMoreScrollViewState extends State<LoadMoreScrollView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
          widget.onLoadMore?.call();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      child: widget.child,
    );
  }
}
