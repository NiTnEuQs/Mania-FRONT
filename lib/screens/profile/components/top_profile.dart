import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/conditional_widget.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_button.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/should_update_provider.dart';
import 'package:mania/providers/user_followings_provider.dart';
import 'package:mania/providers/user_provider.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';
import 'package:mania/utils/string_utils.dart';

class TopProfile extends BaseStatefulWidget {
  const TopProfile({required this.userId});

  final int userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopProfileState();
}

class _TopProfileState extends LifecycleState<TopProfile> {
  late ApiUser _user;
  late bool _isFollowing;

  bool _descriptionCollapsed = true;

  @override
  void onResume() {
    super.onResume();

    ref.read(userProvider).getUser(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(userProvider).user;
    _isFollowing = ref.watch(userFollowingsProvider).users.any((element) => element.id == widget.userId);

    return Padding(
      padding: const EdgeInsets.all(Dimens.marginDouble),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 100),
        child: ConditionalWidget(
          conditions: widget.userId == _user.id,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialHero(
                    tag: '${HeroTags.profileAvatar}${_user.id}',
                    child: RoundedImage(
                      _user.imageUrl,
                      width: Dimens.profileAvatarSize,
                      height: Dimens.profileAvatarSize,
                      isUrl: true,
                    ),
                  ),
                  if (_user.id != Registry.apiUser?.id)
                    ManiaButton(
                      _isFollowing ? trans(context)?.text_unfollow : trans(context)?.text_follow,
                      width: 140,
                      textColor: _isFollowing ? Colors.white : Theme.of(context).textTheme.bodyText2?.color,
                      backgroundColor: _isFollowing ? Colors.red : Theme.of(context).backgroundColor,
                      onPressed: onFollowPressed,
                    )
                  else
                    ManiaButton(
                      trans(context)?.text_editProfile,
                      width: 140,
                      textColor: Theme.of(context).textTheme.bodyText2?.color,
                      backgroundColor: Theme.of(context).backgroundColor,
                      onPressed: onEditProfilePressed,
                    ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: MaterialHero(
                  tag: '${HeroTags.profilePseudo}${_user.id}',
                  child: ManiaText(
                    _user.pseudo,
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
                      tag: '${HeroTags.profileFollowers}${_user.id}',
                      child: ManiaText(
                        trans(context)?.follower(_user.nbFollowers ?? 0),
                        bold: true,
                        onPressed: onFollowersPressed,
                      ),
                    ),
                    MaterialHero(
                      tag: '${HeroTags.profileFollowings}${_user.id}',
                      child: ManiaText(
                        trans(context)?.following(_user.nbFollowings ?? 0),
                        bold: true,
                        onPressed: onFollowingsPressed,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isStringEmpty(_user.bio))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: InkWell(
                    onTap: onDescriptionPressed,
                    child: MaterialHero(
                      tag: '${HeroTags.profileDescription}${_user.id}',
                      child: _descriptionCollapsed
                          ? ManiaText(
                              _user.bio,
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                          : ManiaText(
                              _user.bio,
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
        ),
      ),
    );
  }

  void onFollowPressed() {
    RestClient.service.updateRelation(Registry.apiUser!.id, _user.id, followed: !_isFollowing).then((value) {
      if (value.success) {
        ref.read(userFollowingsProvider).getUsers();
        ref.read(shouldUpdateProvider).updateMainMenuScreen();
      }
    });
  }

  void onEditProfilePressed() {
    Navigator.pushNamed(context, "/profile/edit", arguments: _user);
  }

  void onFollowingsPressed() {
    Navigator.pushNamed(context, "/followings", arguments: _user);
  }

  void onFollowersPressed() {
    Navigator.pushNamed(context, "/followers", arguments: _user);
  }

  void onDescriptionPressed() {
    setState(() {
      _descriptionCollapsed = !_descriptionCollapsed;
    });
  }
}
