import 'package:flutter/material.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/dimensions.dart';

class ProjectsCreateScreen extends BaseStatefulWidget {
  const ProjectsCreateScreen({Key? key}) : super(key: key);

  @override
  _ProjectsCreateScreenState createState() => _ProjectsCreateScreenState();
}

class _ProjectsCreateScreenState extends BaseState<ProjectsCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.margin),
        child: Center(child: ManiaText(trans(context)?.text_emptyList)),
      ),
    );
  }
}
