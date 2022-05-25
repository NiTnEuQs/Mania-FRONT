import 'package:flutter/material.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/future_widget.dart';
import 'package:mania/components/list_users.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/models/generic_response.dart';

class UsersSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.secondary,
      ),
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
    return widgetListUsers(query);
  }

  Widget widgetListUsers(String? query) {
    return FutureBuilder<GenericResponse<List<ApiUser>>>(
      future: RestClient.service.searchUsers(query ?? "", searcherId: Registry.apiUser!.id),
      builder: (context, snapshot) {
        return Scaffold(
          body: FutureWidget(
            snapshot,
            child: ListUsers(snapshot.data?.response),
          ),
        );
      },
    );
  }
}
