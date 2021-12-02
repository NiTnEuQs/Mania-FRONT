import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/transparentinput.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class ManiaBar extends StatelessWidget implements PreferredSizeWidget {
  ManiaBar({Key? key, this.title, this.onSearchValueChanged, this.leftItem, this.rightItem});

  final String? title;
  final Function(String)? onSearchValueChanged;
  final ManiaBarItem? leftItem, rightItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.appbarHeight,
      padding: EdgeInsets.only(
        top: Dimens.appbarMarginTB + MediaQuery.of(context).padding.top,
        bottom: Dimens.appbarMarginTB,
        left: Dimens.appbarMarginLR,
        right: Dimens.appbarMarginLR,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialHero(
            tag: HeroTags.APPBAR_LEFT_BUTTON,
            child: Container(
              height: Dimens.appbarIconsBackgroundSize,
              width: Dimens.appbarIconsBackgroundSize,
              child: leftItem,
            ),
          ),
          Expanded(
            child: MaterialHero(
              tag: HeroTags.TITLE,
              child: (onSearchValueChanged != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: TransparentInput(
                        autofocus: true,
                        placeholder: trans(context)!.text_search,
                        onValueChanged: onSearchValueChanged,
                      ),
                    )
                  : WhiteText(
                      title ?? '',
                      textAlign: TextAlign.center,
                      fontSize: Dimens.appbarTitleSize,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
            ),
          ),
          MaterialHero(
            tag: HeroTags.APPBAR_RIGHT_BUTTON,
            child: Container(
              height: Dimens.appbarIconsBackgroundSize,
              width: Dimens.appbarIconsBackgroundSize,
              child: rightItem,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.appbarHeight);
}

class ManiaBarItem extends StatelessWidget {
  const ManiaBarItem({Key? key, this.icon, this.onItemPressed}) : super(key: key);

  final IconData? icon;
  final VoidCallback? onItemPressed;

  @override
  Widget build(BuildContext context) {
    return RoundOutline(
      color: Colours.appbarIconBackground,
      child: Icon(
        icon ?? Icons.arrow_back,
        color: Colours.appbarIcon,
        size: Dimens.appbarIconsSize,
      ),
      onPressed: onItemPressed,
    );
  }

  static ManiaBarItem back(BuildContext context, {IconData? icon, VoidCallback? onPressed}) => ManiaBarItem(
        icon: icon ?? Icons.arrow_back,
        onItemPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
      );
}
