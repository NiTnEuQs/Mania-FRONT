import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
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
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState(this.user);
}

class _ProfileScreenState extends LifecycleState<ProfileScreen> {
  _ProfileScreenState(this._user);

  final ApiUser _user;

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
          TopProfile(userId: _user.id),
          BotProfile(userId: _user.id),
        ],
      ),
    );
  }

  onWriteMessagePressed() {
    Navigator.pushNamed(context, "/message/write");
  }
}
