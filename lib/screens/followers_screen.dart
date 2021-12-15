import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/components/FutureWidget.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/colours.dart';

class FollowersScreen extends BaseStatefulWidget {
  FollowersScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _FollowersScreenState createState() => _FollowersScreenState(user);
}

class _FollowersScreenState extends LifecycleState<FollowersScreen> {
  _FollowersScreenState(this._user);

  final ApiUser _user;

  @override
  void onResume() {
    super.onResume();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Colours.appBackground,
        extendBodyBehindAppBar: true,
        appBar: ManiaBar(
          title: trans(context)!.screen_followers_title(_user.pseudo),
          leftItem: ManiaBarItem.back(context),
        ),
        body: Background(
          shouldCountBar: true,
          child: FutureBuilder<GenericResponse<List<ApiUser>>>(
            future: RestClient.service.getUserFollowers(_user.id),
            builder: (context, snapshot) {
              return FutureWidget(
                snapshot,
                child: ListUsers(snapshot.data?.response),
              );
            },
          ),
        ),
      ),
    );
  }
}
