import 'package:flutter/material.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/extensions/IntegerExtension.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class CollapsedProfil extends StatelessWidget {
  CollapsedProfil({Key? key, required this.user, this.onUserPressed, this.onUserLongPressed});

  final ApiUser user;
  final Function(ApiUser)? onUserPressed, onUserLongPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onUserPressed != null ? () => onUserPressed!(user) : null,
      onLongPress: onUserLongPressed != null ? () => onUserLongPressed!(user) : null,
      child: Container(
        height: Dimens.collapsedProfileHeight,
        padding: EdgeInsets.only(
          top: Dimens.collapsedProfileSideMargin,
          bottom: Dimens.collapsedProfileSideMargin,
          left: Dimens.collapsedProfileSideMargin,
          right: Dimens.collapsedProfileSideMargin,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Hero(
                tag: '${HeroTags.PROFILE_AVATAR}${user.id}',
                child: RoundedImage(
                  user.imageUrl,
                  width: Dimens.collapsedProfileRoundedPicture,
                  height: Dimens.collapsedProfileRoundedPicture,
                  isUrl: true,
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: '${HeroTags.PROFILE_PSEUDO}${user.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              WhiteText(
                                '${user.pseudo}',
                                boldest: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Hero(
                      //   tag: '${HeroTags.PROFILE_FOLLOWERS}${user.id}',
                      //   child: Material(
                      //     color: Colors.transparent,
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: <Widget>[
                      //         WhiteText(
                      //           user.nbFollowers?.shortify() ?? "",
                      //           bolder: true,
                      //         ),
                      //         WhiteText(
                      //           ' follower'.plurialize(
                      //             user.nbFollowers ?? 0,
                      //             displayAmount: false,
                      //             shortify: true,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Flexible(
                    child: Hero(
                      tag: '${HeroTags.PROFILE_DESCRIPTION}${user.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: WhiteText(
                          user.bio,
                          textAlign: TextAlign.justify,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: RoundOutline(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(0),
                color: Colours.badge,
                child: Center(child: WhiteText('${user.nbMessages?.shortify()}')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
