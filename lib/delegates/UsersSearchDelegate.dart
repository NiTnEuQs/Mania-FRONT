import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/FutureWidget.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';

class UsersSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return widgetListUsers(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return widgetListUsers(null);
  }

  Widget widgetListUsers(String? query) {
    return FutureBuilder<GenericResponse<List<ApiUser>>>(
      future: RestClient.service.searchUsers(query, searcherId: Registry.apiUser!.id),
      builder: (context, snapshot) {
        return Background(
          child: FutureWidget(
            snapshot,
            child: ListUsers(snapshot.data?.response),
          ),
        );
      },
    );
  }
}
