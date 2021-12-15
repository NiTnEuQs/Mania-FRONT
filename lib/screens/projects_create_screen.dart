import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class ProjectsCreateScreen extends StatefulWidget {
  ProjectsCreateScreen({Key? key}) : super(key: key);

  @override
  _ProjectsCreateScreenState createState() => _ProjectsCreateScreenState();
}

class _ProjectsCreateScreenState extends State<ProjectsCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        leftItem: ManiaBarItem.back(context),
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
}
