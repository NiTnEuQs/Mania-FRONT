import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/prefs.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/extensions/theme_mode_extension.dart';
import 'package:mania/handlers/firebase_handler.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/arguments/args_recent_notifications.dart';
import 'package:mania/providers/should_update_provider.dart';
import 'package:mania/providers/theme_mode_provider.dart';
import 'package:mania/providers/user_followings_provider.dart';
import 'package:mania/providers/user_logged_provider.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';
import 'package:mania/screens/pages/notifications_page.dart';

class MainMenuScreen extends BaseStatefulWidget {
  const MainMenuScreen({
    Key? key,
    this.scaffoldKey,
    this.onMenuPressed,
    this.onSearchPressed,
    this.onDrawerChanged,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchPressed;
  final DrawerCallback? onDrawerChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends LifecycleState<MainMenuScreen> {
  late ApiUser _user;

  // int _page = 0;

  // ScrollController _listMessagesController = new ScrollController();
  // final PageController _pageViewController = PageController();

  @override
  void onResume() {
    super.onResume();

    final bool shouldUpdate = ref.watch(shouldUpdateProvider).mainMenuScreen;

    if (shouldUpdate) {
      ref.read(userLoggedProvider).getUser().then((value) {
        _user = ref.watch(userLoggedProvider).user;
        ref.refresh(userRecentNotificationsProvider(ArgsRecentNotifications(_user.id)));
      });

      ref.read(shouldUpdateProvider).updateMainMenuScreen(shouldUpdate: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(userLoggedProvider).user;

    final ThemeMode _themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: ManiaBar(
        noLeading: true,
        titleIcon: SizedBox(
          height: 60,
          child: Image.asset(
            "assets/icon/ic_foreground.png",
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: widget.onSearchPressed,
            ),
          ),
        ],
      ),
      body: const NotificationsPage(),
      // body: PageView(
      //   controller: _pageViewController,
      //   onPageChanged: (index) {
      //     setState(() {
      //       _page = index;
      //     });
      //   },
      //   children: const [
      //     NotificationsPage(),
      //   ],
      // ),
      // bottomNavigationBar: GradientMask(
      //   child: Container(
      //     decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white, width: 1))),
      //     child: BottomNavigationBar(
      //       currentIndex: _page,
      //       backgroundColor: Colors.transparent,
      //       onTap: (index) {
      //         setState(() {
      //           _pageViewController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease).then(
      //             (value) {
      //               _page = index;
      //             },
      //           );
      //         });
      //       },
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home_outlined),
      //           activeIcon: Icon(Icons.home),
      //           label: 'Home',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.search_outlined),
      //           activeIcon: Icon(Icons.search),
      //           label: 'Search',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.notifications_outlined),
      //           activeIcon: Icon(Icons.notifications),
      //           label: 'Notifications',
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: _displayFloatingActionButton
      //     ? FloatingActionButton(
      //         child: Icon(Icons.arrow_upward),
      //         backgroundColor: Theme.of(context).colorScheme.primary,
      //         onPressed: () {
      //           _listMessagesController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
      //         },
      //       )
      //     : null,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.margin),
                child: Container(
                  padding: const EdgeInsets.all(Dimens.marginDouble),
                  decoration: BoxDecoration(
                    color: Colours.primaryColor,
                    borderRadius: BorderRadius.circular(Dimens.blocCornerRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialHero(
                        tag: '${HeroTags.profileAvatar}${_user.id}',
                        child: RoundedImage(
                          _user.imageUrl,
                          onPressed: onDrawerProfilePressed,
                          height: Dimens.profileAvatarSize,
                          width: Dimens.profileAvatarSize,
                          isUrl: true,
                        ),
                      ),
                      const SizedBox(height: Dimens.marginDouble),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialHero(
                            tag: '${HeroTags.profilePseudo}${_user.id}',
                            child: ManiaText.white(
                              _user.pseudo,
                              boldest: true,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialHero(
                                tag: '${HeroTags.profileFollowers}${_user.id}',
                                child: ManiaText.white(
                                  trans(context)?.follower(_user.nbFollowers ?? 0),
                                  onPressed: onDrawerFollowersPressed,
                                ),
                              ),
                              MaterialHero(
                                tag: '${HeroTags.profileFollowings}${_user.id}',
                                child: ManiaText.white(
                                  trans(context)?.following(_user.nbFollowings ?? 0),
                                  onPressed: onDrawerFollowingsPressed,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: ManiaText(trans(context)?.text_profile),
                onTap: onDrawerProfilePressed,
              ),
              // ListTile(
              //   leading: Icon(MdiIcons.gift, color: Colors.white),
              //   title: ManiaText(trans(context)!.text_giveaways),
              //   onTap: onDrawerGiveawaysPressed,
              // ),
              // if (Registry.twitchUser != null)
              //   ListTile(
              //     leading: Icon(MdiIcons.gamepadVariant, color: Colors.white),
              //     title: ManiaText(trans(context)!.text_game_viewers),
              //     onTap: onDrawerGameViewersPressed,
              //   ),
              // ListTile(
              //   leading: Icon(Icons.bolt, color: Colors.white),
              //   title: ManiaText(trans(context)!.text_projects),
              //   onTap: onDrawerProjectsPressed,
              // ),
              // ListTile(
              //   leading: Icon(Icons.settings, color: Colors.white),
              //   title: ManiaText(trans(context)!.text_settings),
              //   onTap: onDrawerSettingsPressed,
              // ),
              ListTile(
                leading: Icon(
                  _themeMode.isDark()
                      ? Icons.dark_mode
                      : _themeMode.isLight()
                          ? Icons.light_mode
                          : Icons.api,
                ),
                title: ManiaText(
                  _themeMode.isDark()
                      ? trans(context)?.text_darkMode
                      : _themeMode.isLight()
                          ? trans(context)?.text_lightMode
                          : trans(context)?.text_systemMode,
                ),
                onTap: onDrawerThemeModePressed,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: ManiaText(
                  trans(context)?.text_logout,
                ),
                onTap: onDrawerLogoutPressed,
              ),
            ],
          ),
        ),
      ),
      onDrawerChanged: widget.onDrawerChanged,
    );
  }

  void onDrawerFollowingsPressed() {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/followings", arguments: _user);
  }

  void onDrawerFollowersPressed() {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/followers", arguments: _user);
  }

  void onDrawerProfilePressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/profile", arguments: _user);
  }

  void onDrawerGiveawaysPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/giveaways");
  }

  void onDrawerGameViewersPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/gameviewers");
  }

  void onDrawerProjectsPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/projects");
  }

  void onDrawerSettingsPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/settings");
  }

  void onDrawerThemeModePressed() {
    final ThemeModeNotifier _themeModeNotifier = ref.read(themeModeProvider.notifier);

    if (_themeModeNotifier.isDark()) {
      _themeModeNotifier.setLight();
    } else if (_themeModeNotifier.isLight()) {
      _themeModeNotifier.setSystem();
    } else {
      _themeModeNotifier.setDark();
    }
  }

  void onDrawerLogoutPressed() {
    if (Registry.firebaseUser != null) {
      FirebaseHandler.signOut(context: context).then((value) {
        Registry.firebaseUser = null;

        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, "/login");
        });
      });
    } else if (Registry.twitchUser != null) {
      Registry.twitchUser = null;
      prefs.remove(Prefs.twitchAccessToken);

      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, "/login");
      });
    }
  }
}
