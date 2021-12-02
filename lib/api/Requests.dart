import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';

class Requests {
  static Future<GenericResponse<ApiUser>> updateUserInformations(BuildContext context) {
    var completer = Completer<GenericResponse<ApiUser>>();

    if (Registry.firebaseUser != null) {
      RestClient.service.getUserInformationWithFirebaseId(Registry.firebaseUser!.uid).then((value) {
        if (value.success) {
          Registry.apiUser = value.response;

          completer.complete(GenericResponse<ApiUser>(success: true, response: Registry.apiUser));
        } else {
          completer.complete(GenericResponse<ApiUser>(success: false));
        }
      }).catchError((error) {
        completer.completeError(error);
      });
    } else {
      completer.complete(GenericResponse<ApiUser>(success: false, message: trans(context)!.isNull("Registry.firebaseUser")));
    }

    return completer.future;
  }

  static Future<GenericResponse<List<ApiUser>>> updateUserFollowings(BuildContext context) {
    var completer = Completer<GenericResponse<List<ApiUser>>>();

    if (Registry.apiUser != null) {
      RestClient.service.getUserFollowings(Registry.apiUser!.id).then((value) {
        if (value.success) {
          Registry.followingUsers = value.response!;

          completer.complete(GenericResponse<List<ApiUser>>(success: true, response: Registry.followingUsers));
        } else {
          completer.complete(GenericResponse<List<ApiUser>>(success: false));
        }
      }).catchError((error) {
        completer.completeError(error);
      });
    } else {
      completer.complete(GenericResponse<List<ApiUser>>(success: false, message: trans(context)!.isNull("Registry.apiUser")));
    }

    return completer.future;
  }
}
