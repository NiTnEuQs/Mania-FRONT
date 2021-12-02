import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/colours.dart';

class FollowingsScreen extends BaseStatefulWidget {
  FollowingsScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _FollowingsScreenState createState() => _FollowingsScreenState(user);
}

class _FollowingsScreenState extends LifecycleState<FollowingsScreen> {
  _FollowingsScreenState(this._user);

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
          title: trans(context)!.screen_followings_title(_user.pseudo),
          leftItem: ManiaBarItem.back(context),
        ),
        body: Background(
          shouldCountBar: true,
          child: FutureBuilder<GenericResponse<List<ApiUser>>>(
            future: RestClient.service.getUserFollowings(_user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListUsers(snapshot.data!.response, onUserPressed: onUserPressed);
              } else if (snapshot.hasError) {
                return Center(child: WhiteText(trans(context)!.text_errorOccurred));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  onUserPressed(ApiUser user) {
    Navigator.pushNamed(context, "/profile", arguments: user);
  }
}
