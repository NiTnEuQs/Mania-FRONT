import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class GameViewersScreen extends StatefulWidget {
  GameViewersScreen({Key? key}) : super(key: key);

  @override
  _GameViewersScreenState createState() => _GameViewersScreenState();
}

class _GameViewersScreenState extends State<GameViewersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        leftItem: ManiaBarItem.back(context),
        rightItem: ManiaBarItem(
          icon: Icons.add,
          onItemPressed: onAddSessionPressed,
        ),
      ),
      body: Background(
        shouldCountBar: true,
        child: Container(
          padding: const EdgeInsets.all(Dimens.margin),
          child: Center(child: WhiteText(trans(context)!.text_emptyList)),
        ),
      ),
    );
  }

  onAddSessionPressed() {
    setState(() {});
  }
}
