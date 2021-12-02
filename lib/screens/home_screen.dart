import 'package:flutter/material.dart';
import 'package:mania/screens/main_menu_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _mainMenuScaffoldKey = new GlobalKey<ScaffoldState>();

  bool _drawerOpened = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: MainMenuScreen(
          scaffoldKey: _mainMenuScaffoldKey,
          onMenuPressed: onMenuPressed,
          onDrawerChanged: onDrawerChanged,
        ),
        floatingActionButton: computedFloatingActionButton(),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit Mania ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ));
  }

  // Computed attributes

  computedFloatingActionButton() {
    if (_drawerOpened) {
      return null;
    } else {
      return FloatingActionButton(
        onPressed: onAddUserPressed,
        child: Icon(Icons.person_add),
      );
    }
  }

  // Callbacks

  onMenuPressed() {
    _mainMenuScaffoldKey.currentState?.openDrawer();
  }

  onAddUserPressed() {
    Navigator.pushNamed(context, "/search");
  }

  onDrawerChanged(isOpen) {
    setState(() {
      _drawerOpened = isOpen;
    });
  }
}
