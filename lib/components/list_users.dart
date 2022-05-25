import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/collapsed_profil.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:string_similarity/string_similarity.dart';

class ListUsers extends BaseStatelessWidget {
  ListUsers(
    this.users, {
    Key? key,
    this.filterValue,
    this.onFollowPressed,
    this.onUserPressed,
    this.onUserLongPressed,
    this.padding = const EdgeInsets.all(Dimens.margin),
    this.separationHeight = Dimens.marginDouble,
  }) : super(key: key);

  final List<ApiUser>? users;
  final String? filterValue;
  final VoidCallback? onFollowPressed;
  final Function(ApiUser)? onUserPressed;
  final Function(ApiUser)? onUserLongPressed;
  final EdgeInsetsGeometry padding;
  final double separationHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ApiUser> users = this.users ?? List.empty(); //computeList();

    return users.isEmpty
        ? Center(child: ManiaText(trans(context)?.text_noUser))
        : ListView.separated(
            padding: padding,
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: separationHeight),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final ApiUser user = users[index];

              return CollapsedProfil(
                user: user,
                onUserPressed: (apiUser) {
                  if (onUserPressed != null) {
                    onUserPressed!(apiUser);
                  } else {
                    defaultOnUserPressed(context, apiUser);
                  }
                },
                onUserLongPressed: onUserLongPressed,
              );
            },
          );
  }

  List<ApiUser> computeList() {
    final List<ApiUser> updatedList = users != null ? List.of(users!) : List.empty();

    if (filterValue != null) {
      updatedList.sort((user1, user2) {
        final double user1Similarity = user1.pseudo.toLowerCase().similarityTo(filterValue?.toLowerCase());
        final double user2Similarity = user2.pseudo.toLowerCase().similarityTo(filterValue?.toLowerCase());
        return user1Similarity == user2Similarity ? 0 : (user2Similarity > user1Similarity ? 1 : -1);
      });
    }

    return updatedList;
  }

  void defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, "/profile", arguments: user);
  }
}
