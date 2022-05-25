import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/requests.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/models/generic_response.dart';
import 'package:mania/models/paginator.dart';
import 'package:mania/providers/api_provider.dart';
import 'package:mania/providers/arguments/args_recent_notifications.dart';

final userRecentNotificationsProvider =
    FutureProvider.family<GenericResponse<Paginator<ApiMessage>>, ArgsRecentNotifications>((ref, argsRecentNotifications) async {
  return ref.read(apiProvider).getRecentNotifications(argsRecentNotifications.userId, argsRecentNotifications.page);
});

final userFollowingsProvider = ChangeNotifierProvider<UserFollowingsNotifier>((ref) => UserFollowingsNotifier(ref));

class UserFollowingsNotifier extends ChangeNotifier {
  UserFollowingsNotifier(this.ref) {
    getUsers();
    getRecentMessages();
  }

  Ref ref;
  List<ApiUser> users = [];
  List<ApiMessage> messages = [];

  Future getUsers() async {
    return Requests.updateUserFollowings().then((value) {
      users = value.response ?? [];
      notifyListeners();
    });
  }

  Future getRecentMessages({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getRecentNotifications(userId, 1).then((value) {
        messages = value.response?.data ?? [];
        notifyListeners();
      });
    }
  }
}
