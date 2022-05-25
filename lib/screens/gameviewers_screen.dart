import 'package:flutter/material.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/dimensions.dart';

class GameViewersScreen extends BaseStatefulWidget {
  const GameViewersScreen({Key? key}) : super(key: key);

  @override
  _GameViewersScreenState createState() => _GameViewersScreenState();
}

class _GameViewersScreenState extends BaseState<GameViewersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ManiaBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: onAddSessionPressed,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(Dimens.margin),
        child: Center(child: ManiaText(trans(context)?.text_emptyList)),
      ),
    );
  }

  void onAddSessionPressed() {
    setState(() {});
  }
}
