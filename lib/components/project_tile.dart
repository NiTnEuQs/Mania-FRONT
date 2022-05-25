import 'package:flutter/material.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/models/api_project.dart';
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
            ManiaText(project?.title ?? ""),
          ],
        ),
      ),
    );
  }
}
