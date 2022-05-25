import 'package:flutter/material.dart';
import 'package:mania/api/requests.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/rounded_button.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/should_update_provider.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';

class CollapsedProfil extends BaseStatefulWidget {
  const CollapsedProfil({
    required this.user,
    this.onUserPressed,
    this.onUserLongPressed,
  });

  final ApiUser user;
  final Function(ApiUser)? onUserPressed;
  final Function(ApiUser)? onUserLongPressed;

  @override
  _CollapsedProfilState createState() => _CollapsedProfilState();
}

class _CollapsedProfilState extends BaseState<CollapsedProfil> {
  late bool _isFollowingUser;

  @override
  Widget build(BuildContext context) {
    _isFollowingUser = Registry.followingUsers.contains(widget.user);

    return SizedBox(
      height: Dimens.collapsedProfileHeight,
      child: RoundedContainer(
        onPressed: widget.onUserPressed != null ? () => widget.onUserPressed!(widget.user) : null,
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(Dimens.collapsedProfileSideMargin),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Hero(
                tag: '${HeroTags.profileAvatar}${widget.user.id}',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: '${HeroTags.profilePseudo}${widget.user.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              ManiaText(
                                widget.user.pseudo,
                                bolder: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Hero(
                      tag: '${HeroTags.profileDescription}${widget.user.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: ManiaText(
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
            Padding(
              padding: const EdgeInsets.only(left: Dimens.margin),
              child: Tooltip(
                message: _isFollowingUser ? trans(context)?.text_unfollow : trans(context)?.text_follow,
                child: RoundedContainer(
                  height: 35,
                  width: 35,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: onFollowUserPressed,
                  child: Icon(
                    _isFollowingUser ? Icons.clear : Icons.person_add,
                    size: _isFollowingUser ? 16 : 18,
                    color: _isFollowingUser ? Colors.red : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFollowUserPressed() {
    RestClient.service.updateRelation(Registry.apiUser!.id, widget.user.id, followed: !_isFollowingUser).then((value) {
      Requests.updateUserFollowings().then((value) {
        setState(() {});
        ref.read(shouldUpdateProvider).updateMainMenuScreen();
      });
    });
  }
}
