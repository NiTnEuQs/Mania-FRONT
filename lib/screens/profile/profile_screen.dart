import 'package:flutter/material.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/screens/profile/components/bot_profile.dart';
import 'package:mania/screens/profile/components/top_profile.dart';

class ProfileScreen extends BaseStatefulWidget {
  ProfileScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends LifecycleState<ProfileScreen> {
  _ProfileScreenState();

  @override
  void onResume() {
    super.onResume();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        leftItem: ManiaBarItem.back(context),
      ),
      body: Column(
        children: <Widget>[
          TopProfile(userId: widget.user.id, onFollowPressed: onFollowPressed),
          BotProfile(userId: widget.user.id),
        ],
      ),
    );
  }

  onFollowPressed() {
    setState(() {});
    Requests.updateUserFollowings(context);
  }

  onWriteMessagePressed() {
    Navigator.pushNamed(context, "/message/write");
  }
}
