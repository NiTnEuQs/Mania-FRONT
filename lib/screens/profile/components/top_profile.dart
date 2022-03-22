import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/FutureWidget.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/whitebutton.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';
import 'package:mania/utils/StringUtils.dart';

class TopProfile extends StatefulWidget {
  TopProfile({Key? key, required this.userId, this.onFollowPressed});

  final int userId;
  final VoidCallback? onFollowPressed;

  @override
  State<TopProfile> createState() => _TopProfileState();
}

class _TopProfileState extends State<TopProfile> {
  ApiUser? _user;
  late bool _isFollowing;

  bool _descriptionCollapsed = true;

  @override
  void initState() {
    super.initState();

    _isFollowing = Registry.followingUsers.any((element) => element.id == widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      shouldCountBar: true,
      padding: const EdgeInsets.all(Dimens.marginDouble),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(Dimens.blocCornerRadius),
        bottomRight: Radius.circular(Dimens.blocCornerRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 100),
        child: FutureBuilder<GenericResponse<ApiUser>>(
          future: RestClient.service.getUserInformationWithUserId(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) _user = snapshot.data!.response!;

            return FutureWidget(
              snapshot,
              child: _user == null
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialHero(
                              tag: '${HeroTags.PROFILE_AVATAR}${_user?.id}',
                              child: RoundedImage(
                                _user?.imageUrl,
                                width: Dimens.profileAvatarSize,
                                height: Dimens.profileAvatarSize,
                                isUrl: true,
                              ),
                            ),
                            _user?.id != Registry.apiUser?.id
                                ? WhiteButton(
                                    _isFollowing ? trans(context)!.text_unfollow : trans(context)!.text_follow,
                                    width: 140,
                                    color: _isFollowing ? Colors.red : null,
                                    textColor: _isFollowing ? Colors.white : null,
                                    onPressed: onFollowPressed,
                                  )
                                : WhiteButton(
                                    trans(context)!.text_editProfile,
                                    width: 140,
                                    onPressed: onEditProfilePressed,
                                  ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: MaterialHero(
                            tag: '${HeroTags.PROFILE_PSEUDO}${_user?.id}',
                            child: WhiteText(
                              '${_user?.pseudo}',
                              boldest: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MaterialHero(
                                tag: '${HeroTags.PROFILE_FOLLOWERS}${_user?.id}',
                                child: WhiteText(
                                  trans(context)!.follower(_user?.nbFollowers ?? 0),
                                  onPressed: onFollowersPressed,
                                ),
                              ),
                              MaterialHero(
                                tag: '${HeroTags.PROFILE_FOLLOWINGS}${_user?.id}',
                                child: WhiteText(
                                  trans(context)!.following(_user?.nbFollowings ?? 0),
                                  onPressed: onFollowingsPressed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isStringEmpty(_user?.bio))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: InkWell(
                              onTap: onDescriptionPressed,
                              child: MaterialHero(
                                tag: '${HeroTags.PROFILE_DESCRIPTION}${_user?.id}',
                                child: _descriptionCollapsed
                                    ? WhiteText(
                                        _user?.bio,
                                        textAlign: TextAlign.justify,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : WhiteText(
                                        _user?.bio,
                                        textAlign: TextAlign.justify,
                                      ),
                              ),
                            ),
                          ),
                        // Tags(
                        //   _user.tags ?? List.empty(),
                        //   textColor: Theme.of(context).colorScheme.primary,
                        // ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  onFollowPressed() {
    if (_user != null) {
      RestClient.service.updateRelation(Registry.apiUser!.id, _user!.id, followed: !_isFollowing).then((value) {
        if (value.success) {
          updateAlreadyFollowing(value.response?.followed ?? false);

          if (widget.onFollowPressed != null) widget.onFollowPressed!();
        }
      });
    }
  }

  updateAlreadyFollowing(bool following) {
    if (mounted) {
      setState(() {
        _isFollowing = following;
      });
    }
  }

  onEditProfilePressed() {
    Navigator.pushNamed(context, "/profile/edit", arguments: _user);
  }

  onFollowingsPressed() {
    Navigator.pushNamed(context, "/followings", arguments: _user);
  }

  onFollowersPressed() {
    Navigator.pushNamed(context, "/followers", arguments: _user);
  }

  onDescriptionPressed() {
    setState(() {
      _descriptionCollapsed = !_descriptionCollapsed;
    });
  }
}
