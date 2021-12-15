import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class GiveAwaysScreen extends StatefulWidget {
  GiveAwaysScreen({Key? key}) : super(key: key);

  @override
  _GiveAwaysScreenState createState() => _GiveAwaysScreenState();
}

class _GiveAwaysScreenState extends State<GiveAwaysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        leftItem: ManiaBarItem.back(context),
        rightItem: ManiaBarItem(
          icon: Icons.add,
          onItemPressed: onAddGiveawayPressed,
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

  onAddGiveawayPressed() {
    setState(() {});
  }
}
