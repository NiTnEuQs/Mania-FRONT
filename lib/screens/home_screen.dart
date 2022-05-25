import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/delegates/users_search_delegate.dart';
import 'package:mania/screens/main_menu_screen.dart';

class HomeScreen extends BaseStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  final GlobalKey<ScaffoldState> _mainMenuScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: MainMenuScreen(
        scaffoldKey: _mainMenuScaffoldKey,
        onMenuPressed: onMenuPressed,
        onSearchPressed: onSearchPressed,
      ),
    );
  }

  Future<bool> onBackPressed() async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit Mania ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      ).then((x) => x ?? false);

  // Callbacks

  void onMenuPressed() {
    _mainMenuScaffoldKey.currentState?.openDrawer();
  }

  void onSearchPressed() {
    showSearch(
      context: context,
      delegate: UsersSearchDelegate(),
    );
  }
}
