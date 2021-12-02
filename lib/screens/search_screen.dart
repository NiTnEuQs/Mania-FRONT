import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';

class SearchScreen extends BaseStatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends LifecycleState<SearchScreen> {
  String _searchValue = "";
  int _searchRequests = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ManiaBar(
        onSearchValueChanged: onSearchValueChanged,
        leftItem: ManiaBarItem.back(context),
      ),
      body: Background(
        shouldCountBar: true,
        child: FutureBuilder<GenericResponse<List<ApiUser>>>(
          initialData: GenericResponse<List<ApiUser>>(success: true),
          future: RestClient.service.searchUsers(_searchValue),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListUsers(snapshot.data!.response, filterValue: _searchValue, onUserPressed: onUserPressed);
            } else if (snapshot.hasError) {
              return Center(child: WhiteText(trans(context)!.text_errorOccurred));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  onSearchValueChanged(String value) {
    _searchValue = value;

    _searchRequests++;
    Future.delayed(Duration(milliseconds: 500), () {
      if (--_searchRequests == 0) {
        if (mounted) setState(() {});
      }
    });
  }

  onBackPressed() {
    Navigator.pop(context);
  }

  onUserPressed(ApiUser user) {
    Navigator.pushNamed(context, "/profile", arguments: user);
  }
}
