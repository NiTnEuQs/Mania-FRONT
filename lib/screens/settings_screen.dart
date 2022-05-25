import 'package:flutter/material.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/dimensions.dart';

class SettingsScreen extends BaseStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ManiaBar(),
      body: Container(
        padding: const EdgeInsets.all(Dimens.margin),
        child: Center(child: ManiaText(trans(context)?.text_emptyList)),
      ),
    );
  }
}
