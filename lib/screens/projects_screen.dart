import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/project_tile.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiProject.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class ProjectsScreen extends StatefulWidget {
  ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<ApiProject> _projects = [];

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
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        leftItem: ManiaBarItem.back(context),
        rightItem: ManiaBarItem(
          icon: Icons.add,
          onItemPressed: onAddProjectPressed,
        ),
      ),
      body: Background(
        shouldCountBar: true,
        child: Container(
          padding: const EdgeInsets.all(Dimens.margin),
          child: _projects.length > 0
              ? GridView.builder(
                  itemCount: _projects.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) {
                    ApiProject apiProject = _projects[index];
                    return ProjectTile(
                      apiProject,
                      onPressed: onProjectPressed,
                    );
                  },
                )
              : Center(child: WhiteText(trans(context)!.text_emptyList)),
        ),
      ),
    );
  }

  onProjectPressed() {
    print("Project pressed");
  }

  onAddProjectPressed() {
    _projects.add(ApiProject(id: 0, title: "Royaumes", color: Colors.red));

    setState(() {});
  }
}
