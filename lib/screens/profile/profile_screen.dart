import 'package:flutter/material.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/app/Registry.dart';
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
        rightItem: widget.user.id == Registry.apiUser?.id
            ? ManiaBarItem(
                icon: Icons.mode,
                onItemPressed: onWriteMessagePressed,
              )
            : null,
      ),
      body: Column(
        children: <Widget>[
          TopProfile(userId: widget.user.id, onFollowPressed: onFollowPressed),
          BotProfile(userId: widget.user.id, onMessagePressed: onMessagePressed),
        ],
      ),
    );
  }

  onFollowPressed() {
    setState(() {});
    Requests.updateUserFollowings(context);
  }

  onMessagePressed(message) {
    Navigator.pushNamed(context, "/message", arguments: message);
  }

  onWriteMessagePressed() {
    Navigator.pushNamed(context, "/message/write");
  }
}
