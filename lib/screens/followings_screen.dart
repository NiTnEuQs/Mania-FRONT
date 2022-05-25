import 'package:flutter/material.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/components/future_widget.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/models/generic_response.dart';

class FollowingsScreen extends BaseStatefulWidget {
  const FollowingsScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _FollowingsScreenState createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends LifecycleState<FollowingsScreen> {
  _FollowingsScreenState();

  late final ApiUser _user;

  @override
  void initState() {
    super.initState();

    _user = widget.user;
  }

  @override
  void onResume() {
    super.onResume();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ManiaBar(
        title: trans(context)?.screen_followings_title(_user.pseudo),
      ),
      body: FutureBuilder<GenericResponse<List<ApiUser>>>(
        future: RestClient.service.getUserFollowings(_user.id),
        builder: (context, snapshot) {
          return FutureWidget(
            snapshot,
            child: ListUsers(snapshot.data?.response),
          );
        },
      ),
    );
  }
}
