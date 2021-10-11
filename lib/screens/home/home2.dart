import 'package:flutter/material.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/cleanbar.dart';
import 'package:mania/components/profil.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class Home2Screen extends StatefulWidget {
  Home2Screen({Key? key}) : super(key: key);

  @override
  _Home2ScreenState createState() => _Home2ScreenState();
}

class _Home2ScreenState extends State<Home2Screen> {
  String _pseudo = "";

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    onProfilChanged(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: CleanBar(title: _pseudo),
      body: Stack(
        children: <Widget>[
          Background(
            hasBar: true,
            radius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimens.blocCornerRadius),
              bottomRight: Radius.circular(Dimens.blocCornerRadius),
            ),
            child: Container(height: Dimens.topProfilHeight - Dimens.topProfilSideMargin - Dimens.appbarMargin),
          ),
          PageView(
            controller: controller,
            onPageChanged: onProfilChanged,
            children: <Widget>[Profil(), Profil(), Profil()],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onNewNotificationPressed,
        tooltip: 'Write a notif',
        child: Icon(Icons.rate_review),
      ),
    );
  }

  onProfilChanged(int index) {
    setState(() {
      _pseudo = 'Pseudo $index';
    });
  }

  onNewNotificationPressed() {
    print('New notification');
  }
}
