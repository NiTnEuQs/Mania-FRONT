import 'package:flutter/material.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class CleanBar extends StatelessWidget implements PreferredSizeWidget {
  CleanBar({Key? key, this.title, this.displayBack, this.displayProfil});

  final String? title;
  final bool? displayBack, displayProfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimens.appbarMargin + MediaQuery.of(context).padding.top,
        bottom: Dimens.appbarMargin,
        left: Dimens.appbarMargin,
        right: Dimens.appbarMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RoundOutline(
            color: Colours.appbarIconBackground,
            child: Icon(Icons.person, color: Colours.appbarIcon),
          ),
          WhiteText(
            title ?? '',
            fontSize: Dimens.appbarTitleSize,
          ),
          RoundOutline(
            color: Colours.appbarIconBackground,
            child: Icon(Icons.search, color: Colours.appbarIcon),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.appbarHeight);
}
