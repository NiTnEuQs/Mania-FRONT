import 'package:flutter/material.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';
import 'package:mania/utils/authentication.dart';

class MainMenuScreen extends BaseStatefulWidget {
  MainMenuScreen({
    Key? key,
    this.scaffoldKey,
    this.onMenuPressed,
    this.onOwnProfilePressed,
    this.onDrawerChanged,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onMenuPressed, onOwnProfilePressed;
  final DrawerCallback? onDrawerChanged;

  @override
  _MainMenuPageState createState() => _MainMenuPageState(Registry.apiUser);
}

class _MainMenuPageState extends LifecycleState<MainMenuScreen> {
  _MainMenuPageState(this._user);

  ApiUser? _user;

  @override
  onResume() {
    super.onResume();

    Requests.updateUserInformations(context).then((value) {
      if (value.success) {
        _user = Registry.apiUser;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        title: trans(context)!.screen_mainMenu_title,
        leftItem: ManiaBarItem(
          icon: Icons.menu,
          onItemPressed: widget.onMenuPressed,
        ),
      ),
      // appBar: MainMenuBar(title: trans(context)!.mainMenu_yourList, onMenuPressed: widget.onMenuPressed),
      body: Background(
        shouldCountBar: true,
        child: FutureBuilder<GenericResponse<List<ApiUser>>>(
          future: RestClient.service.getUserFollowings(Registry.apiUser!.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Registry.followingUsers = snapshot.data!.response!;
              return ListUsers(Registry.followingUsers, onUserPressed: onUserPressed, onUserLongPressed: onUserLongPressed);
            } else if (snapshot.hasError) {
              return Center(child: WhiteText(trans(context)!.text_errorOccurred));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: Drawer(
        child: Background(
          padding: EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: Dimens.topDrawer,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colours.blackOverlay,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialHero(
                        tag: '${HeroTags.PROFILE_AVATAR}${_user?.id}',
                        child: RoundedImage(
                          _user?.imageUrl,
                          height: Dimens.profileAvatarSize,
                          width: Dimens.profileAvatarSize,
                          isUrl: true,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialHero(
                            tag: '${HeroTags.PROFILE_PSEUDO}${_user?.id}',
                            child: WhiteText(
                              "${_user?.pseudo}",
                              boldest: true,
                            ),
                          ),
                          MaterialHero(
                            tag: '${HeroTags.PROFILE_FOLLOWERS}${_user?.id}',
                            child: WhiteText("${trans(context)!.follower(_user?.nbFollowers ?? 0)}"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: WhiteText(trans(context)!.text_profile),
                onTap: onDrawerProfilePressed,
              ),
              // ListTile(
              //   leading: Icon(Icons.settings, color: Colors.white),
              //   title: WhiteText(AppLocalizations.of(context)!.drawer_settings),
              //   onTap: onDrawerSettingsPressed,
              // ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: WhiteText(trans(context)!.text_logout),
                onTap: onDrawerLogoutPressed,
              ),
            ],
          ),
        ),
      ),
      onDrawerChanged: widget.onDrawerChanged,
    );
  }

  onUserPressed(ApiUser user) {
    Navigator.pushNamed(context, '/profile', arguments: user);
  }

  onUserLongPressed(ApiUser user) {}

  onDrawerProfilePressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/profile", arguments: _user);
  }

  onDrawerSettingsPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/settings");
  }

  onDrawerLogoutPressed() {
    Authentication.signOut(context: context).then((value) {
      Registry.firebaseUser = null;

      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, "/login");
      });
    });
  }
}
