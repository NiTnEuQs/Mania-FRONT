import 'package:flutter/material.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/project_tile.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_project.dart';
import 'package:mania/resources/dimensions.dart';

class ProjectsScreen extends BaseStatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends BaseState<ProjectsScreen> {
  final List<ApiProject> _projects = [];

  @override
  void initState() {
    super.initState();

    // _projects = [
    //   ApiProject(id: 1, title: "Royaumes", color: Colors.red),
    //   ApiProject(id: 2, title: "Army League", color: Colors.blue),
    //   ApiProject(id: 3, title: "KNS", color: Colors.green),
    //   ApiProject(id: 4, title: "Royaumes", color: Colors.yellow),
    // ];
  }

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
              onPressed: onAddProjectPressed,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(Dimens.margin),
        child: _projects.isNotEmpty
            ? GridView.builder(
                itemCount: _projects.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                ),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  final ApiProject apiProject = _projects[index];
                  return ProjectTile(
                    apiProject,
                    onPressed: onProjectPressed,
                  );
                },
              )
            : Center(child: ManiaText(trans(context)?.text_emptyList)),
      ),
    );
  }

  void onProjectPressed() {}

  void onAddProjectPressed() {
    _projects.add(ApiProject(id: 0, title: "Royaumes", color: Colors.red));

    setState(() {});
  }
}
