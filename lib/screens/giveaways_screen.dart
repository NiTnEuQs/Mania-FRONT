import 'package:flutter/material.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/dimensions.dart';

class GiveAwaysScreen extends BaseStatefulWidget {
  const GiveAwaysScreen({Key? key}) : super(key: key);

  @override
  _GiveAwaysScreenState createState() => _GiveAwaysScreenState();
}

class _GiveAwaysScreenState extends BaseState<GiveAwaysScreen> {
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
              onPressed: onAddGiveawayPressed,
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

  void onAddGiveawayPressed() {
    setState(() {});
  }
}
