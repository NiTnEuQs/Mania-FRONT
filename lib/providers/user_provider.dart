import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) => UserNotifier(ref));

class UserNotifier extends ChangeNotifier {
  UserNotifier(this.ref) {
    getUser();
    getMessages();
  }

  Ref ref;
  ApiUser user = ApiUser.empty;
  List<ApiMessage> messages = [];

  Future getUser({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getUserInformationWithUserId(userId).then((value) {
        user = value.response ?? ApiUser.empty;
        notifyListeners();
      });
    }
  }

  Future getMessages({int? userId}) async {
    if (userId != null) {
      return RestClient.service.getUserMessages(userId).then((value) {
        messages = value.response ?? [];
        notifyListeners();
      });
    }
  }
}
