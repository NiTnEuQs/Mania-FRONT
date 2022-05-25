import 'package:flutter/material.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key, this.title, this.child}) : super(key: key);

  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: MaterialHero(
              tag: HeroTags.title,
              child: ManiaText(
                title ?? '',
                textAlign: TextAlign.center,
                fontSize: Dimens.appbarTitleSize,
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          // backgroundColor: Colors.transparent,
          floating: true,
          snap: true,
          // title: MaterialHero(
          //   tag: HeroTags.TITLE,
          //   child: WhiteText(
          //     title ?? '',
          //     textAlign: TextAlign.center,
          //     fontSize: Dimens.appbarTitleSize,
          //     maxLines: 1,
          //     overflow: TextOverflow.visible,
          //   ),
          // ),
          // actions: [
          //   leftItem,
          //   rightItem,
          // ],
        ),
        child!,
      ],
    );
  }
}
