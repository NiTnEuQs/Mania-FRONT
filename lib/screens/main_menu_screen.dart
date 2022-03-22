import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:mania/app/Prefs.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/System.dart';
import 'package:mania/components/ConditionalWidget.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/gradientmask.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/handlers/FirebaseHandler.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/providers/UserFollowingsProvider.dart';
import 'package:mania/providers/UserLoggedProvider.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainMenuScreen extends BaseStatefulWidget {
  MainMenuScreen({
    Key? key,
    this.scaffoldKey,
    this.onMenuPressed,
    this.onSearchPressed,
    this.onDrawerChanged,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onMenuPressed, onSearchPressed;
  final DrawerCallback? onDrawerChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends LifecycleState<MainMenuScreen> {
  late ApiUser _user;
  late List<ApiMessage> _recentMessages;

  bool _displayFloatingActionButton = false;
  ScrollController _listMessagesController = new ScrollController();
  ScrollController _listMessagesChildController = new ScrollController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _listMessagesController.addListener(() {
      if (_listMessagesController.offset > 100.0) {
        if (!_displayFloatingActionButton)
          setState(() {
            _displayFloatingActionButton = true;
          });
      } else {
        if (_displayFloatingActionButton)
          setState(() {
            _displayFloatingActionButton = false;
          });
      }
    });
  }

  @override
  onResume() {
    super.onResume();

    ref.read(userLoggedProvider).getUser().then((value) {
      _user = ref.watch(userLoggedProvider).user;
      ref.read(userFollowingsProvider).getRecentMessages(userId: _user.id);
    });

    // Future.delayed(Duration(milliseconds: 350), () {
    //   System.transparentStatusBar();
    // });
  }

  void _onRefresh() async {
    ref.read(userFollowingsProvider).getRecentMessages(userId: _user.id).whenComplete(
          _refreshController.refreshCompleted,
        );
    // // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use refreshFailed()
    // _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // // if failed,use loadFailed(),if no data return,use LoadNodata()
    // // items.add((items.length + 1).toString());
    // if (mounted) setState(() {});
    // _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(userLoggedProvider).user;
    _recentMessages = ref.watch(userFollowingsProvider).messages;

    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
            // title: Row(
            //   children: [
            //     Container(
            //       height: 50,
            //       child: ShaderMask(
            //         blendMode: BlendMode.srcIn,
            //         shaderCallback: (bounds) => LinearGradient(colors: [
            //           Colours.secondaryColor,
            //           Colours.primaryColor,
            //         ]).createShader(
            //           Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            //         ),
            //         child: Image.asset("assets/icon/ic_foreground.png"),
            //       ),
            //     ),
            //     GradientText(
            //       trans(context)!.screen_mainMenu_title,
            //       gradient: LinearGradient(colors: [
            //         Colours.secondaryColor,
            //         Colours.primaryColor,
            //       ]),
            //       textAlign: TextAlign.center,
            //       fontSize: Dimens.appbarTitleSize,
            //       maxLines: 1,
            //       overflow: TextOverflow.visible,
            //     ),
            //   ],
            // ),
            title: Center(
              child: Container(
                height: 60,
                child: GradientMask(
                  child: Image.asset("assets/icon/ic_foreground.png"),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: widget.onSearchPressed,
                ),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(Dimens.halfMargin),
              child: SmartRefresher(
            header: WaterDropHeader(
              refresh: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
                    ),
                      waterDropColor: Theme.of(context).colorScheme.secondary,
                      complete: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GradientMask(
                            child: Icon(
                              Icons.done,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    controller: _refreshController,
                    scrollController: _listMessagesController,
                    child: ConditionalWidget(
                      conditions: _recentMessages.isNotEmpty,
                      child: ListMessages(
                        _recentMessages,
                        controller: _listMessagesChildController,
                        displayAvatar: true,
                        displayPseudo: true,
                        displayWriteAMessage: true,
                        openExtendedWriter: true,

                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _displayFloatingActionButton
          ? FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                _listMessagesController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            )
          : null,
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
                        tag: '${HeroTags.PROFILE_AVATAR}${_user.id}',
                        child: RoundedImage(
                          _user.imageUrl,
                          onPressed: onDrawerProfilePressed,
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
                            tag: '${HeroTags.PROFILE_PSEUDO}${_user.id}',
                            child: WhiteText(
                              "${_user.pseudo}",
                              boldest: true,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialHero(
                                tag: '${HeroTags.PROFILE_FOLLOWERS}${_user.id}',
                                child: WhiteText(
                                  "${trans(context)!.follower(_user.nbFollowers ?? 0)}",
                                  onPressed: onDrawerFollowersPressed,
                                ),
                              ),
                              MaterialHero(
                                tag: '${HeroTags.PROFILE_FOLLOWINGS}${_user.id}',
                                child: WhiteText(
                                  "${trans(context)!.following(_user.nbFollowings ?? 0)}",
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
                leading: Icon(Icons.person, color: Colors.white),
                title: WhiteText(trans(context)!.text_profile),
                onTap: onDrawerProfilePressed,
              ),
              ListTile(
                leading: Icon(MdiIcons.gift, color: Colors.white),
                title: WhiteText(trans(context)!.text_giveaways),
                onTap: onDrawerGiveawaysPressed,
              ),
              if (Registry.twitchUser != null)
                ListTile(
                  leading: Icon(MdiIcons.gamepadVariant, color: Colors.white),
                  title: WhiteText(trans(context)!.text_game_viewers),
                  onTap: onDrawerGameViewersPressed,
                ),
              ListTile(
                leading: Icon(Icons.bolt, color: Colors.white),
                title: WhiteText(trans(context)!.text_projects),
                onTap: onDrawerProjectsPressed,
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: WhiteText(trans(context)!.text_settings),
                onTap: onDrawerSettingsPressed,
              ),
              ListTile(
                leading: Icon(System.isDarkMode() ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
                title: WhiteText(System.isDarkMode() ? trans(context)!.text_light_mode : trans(context)!.text_dark_mode),
                onTap: onDrawerThemeModePressed,
              ),
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

  onDrawerFollowingsPressed() {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/followings", arguments: _user);
  }

  onDrawerFollowersPressed() {
    Navigator.pop(context);
    Navigator.pushNamed(context, "/followers", arguments: _user);
  }

  onDrawerProfilePressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/profile", arguments: _user);
  }

  onDrawerGiveawaysPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/giveaways");
  }

  onDrawerGameViewersPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/gameviewers");
  }

  onDrawerProjectsPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/projects");
  }

  onDrawerSettingsPressed() {
    Navigator.pop(context);

    Navigator.pushNamed(context, "/settings");
  }

  onDrawerThemeModePressed() {
    Navigator.pop(context);

    if (System.isDarkMode()) {
      System.themeMode = ThemeMode.light;
    } else if (System.isLightMode()) {
      System.themeMode = ThemeMode.system;
    } else {
      System.themeMode = ThemeMode.dark;
    }

    setState(() {});
  }

  onDrawerLogoutPressed() {
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
