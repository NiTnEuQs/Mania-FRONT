import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/collapsed_profil.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/colours.dart';
import 'package:string_similarity/string_similarity.dart';

class ListUsers extends StatelessWidget {
  ListUsers(
    this.users, {
    Key? key,
    this.filterValue,
    this.noDataColor = Colors.white,
    this.onFollowPressed,
    this.onUserPressed,
    this.onUserLongPressed,
  }) : super(key: key);

  final List<ApiUser>? users;
  final String? filterValue;
  final Color noDataColor;
  final VoidCallback? onFollowPressed;
  final Function(ApiUser)? onUserPressed, onUserLongPressed;

  @override
  Widget build(BuildContext context) {
    List<ApiUser> users = this.users ?? List.empty(); //computeList();

    return users.length <= 0
        ? Center(child: WhiteText(trans(context)!.text_noUser, color: noDataColor))
        : ListView.separated(
            padding: EdgeInsets.all(0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              ApiUser user = users[index];

              return CollapsedProfil(
                user: user,
                onUserPressed: (apiUser) {
                  if (onUserPressed != null)
                    onUserPressed!(apiUser);
                  else
                    defaultOnUserPressed(context, apiUser);
                },
                onUserLongPressed: onUserLongPressed,
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              height: 1,
              color: Colours.separator,
            ),
          );
  }

  computeList() {
    List<ApiUser> updatedList = users != null ? List.of(users!) : List.empty();

    if (filterValue != null) {
      updatedList.sort((user1, user2) {
        double user1Similarity = user1.pseudo.toLowerCase().similarityTo(filterValue?.toLowerCase());
        double user2Similarity = user2.pseudo.toLowerCase().similarityTo(filterValue?.toLowerCase());
        return user1Similarity == user2Similarity ? 0 : (user2Similarity > user1Similarity ? 1 : -1);
      });
    }

    return updatedList;
  }

  defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, "/profile", arguments: user);
  }
}
