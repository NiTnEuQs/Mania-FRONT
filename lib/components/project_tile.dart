import 'package:flutter/material.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiProject.dart';
import 'package:mania/resources/dimensions.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile(this.project, {Key? key, this.padding, this.onPressed}) : super(key: key);

  final ApiProject? project;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: project?.color,
        padding: padding ?? const EdgeInsets.all(Dimens.margin),
        child: Column(
          children: [
            Expanded(
              child: RoundedImage(
                Registry.apiUser?.imageUrl,
                isUrl: true,
                width: Dimens.profileAvatarSize,
                height: Dimens.profileAvatarSize,
              ),
            ),
            WhiteText(project?.title ?? ""),
          ],
        ),
      ),
    );
  }
}
