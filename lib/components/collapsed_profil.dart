import 'package:flutter/material.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class CollapsedProfil extends StatefulWidget {
  CollapsedProfil({Key? key, required this.user, this.onUserPressed, this.onUserLongPressed});

  final ApiUser user;
  final Function(ApiUser)? onUserPressed, onUserLongPressed;

  @override
  State<CollapsedProfil> createState() => _CollapsedProfilState();
}

class _CollapsedProfilState extends State<CollapsedProfil> {
  late bool _isFollowingUser;

  @override
  Widget build(BuildContext context) {
    _isFollowingUser = Registry.followingUsers.contains(widget.user);

    return InkWell(
      onTap: widget.onUserPressed != null ? () => widget.onUserPressed!(widget.user) : null,
      onLongPress: widget.onUserLongPressed != null ? () => widget.onUserLongPressed!(widget.user) : null,
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
                tag: '${HeroTags.PROFILE_AVATAR}${widget.user.id}',
                child: RoundedImage(
                  widget.user.imageUrl,
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
                        tag: '${HeroTags.PROFILE_PSEUDO}${widget.user.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              WhiteText(
                                '${widget.user.pseudo}',
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
                      tag: '${HeroTags.PROFILE_DESCRIPTION}${widget.user.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: WhiteText(
                          widget.user.bio,
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
            // Padding(
            //   padding: const EdgeInsets.only(left: 8),
            //   child: RoundOutline(
            //     height: 30,
            //     width: 30,
            //     padding: const EdgeInsets.all(0),
            //     color: Colours.badge,
            //     child: Center(child: WhiteText('${user.nbMessages?.shortify()}')),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: RoundOutline(
                height: 30,
                width: 30,
                onPressed: onFollowUserPressed,
                color: _isFollowingUser ? Colors.red : Colors.white,
                child: Icon(
                  _isFollowingUser ? Icons.remove : Icons.person_add,
                  size: 16,
                  color: _isFollowingUser ? Colors.white : Colours.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onFollowUserPressed() {
    RestClient.service.updateRelation(Registry.apiUser!.id, widget.user.id, followed: !_isFollowingUser).then((value) {
      Requests.updateUserFollowings(context).then((value) {
        setState(() {});
      });
    });
  }
}
