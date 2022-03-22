import 'dart:async';

import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';

class Requests {
  static Future<GenericResponse<ApiUser>> getUserInformations() {
    var completer = Completer<GenericResponse<ApiUser>>();

    if (Registry.firebaseUser != null) {
      RestClient.service.getUserInformationWithFirebaseId(Registry.firebaseUser!.uid).then((value) {
        if (value.success) {
          Registry.apiUser = value.response;

          completer.complete(GenericResponse<ApiUser>(success: true, response: Registry.apiUser));
        } else {
          RestClient.service.createUserInformationFromFirebaseUser(Registry.firebaseUser!.uid).then((value) {
            if (value.success) {
              Registry.apiUser = value.response;

              completer.complete(GenericResponse<ApiUser>(success: true, response: Registry.apiUser));
            } else {
              completer.complete(GenericResponse<ApiUser>(success: false));
            }
          }).catchError((error) {
            completer.completeError(error);
          });
        }
      }).catchError((error) {
        completer.completeError(error);
      });
    } else if (Registry.twitchUser != null) {
      RestClient.service.getUserInformationWithTwitchId(Registry.twitchUser!.id).then((value) {
        if (value.success) {
          Registry.apiUser = value.response;

          RestClient.service
              .editProfile(Registry.apiUser!.id, pseudo: Registry.twitchUser!.displayName, avatarUrl: Registry.twitchUser!.profileImageUrl)
              .then((value) {
            completer.complete(GenericResponse<ApiUser>(success: true, response: Registry.apiUser));
          }).catchError((error) {
            completer.complete(GenericResponse<ApiUser>(success: false));
          });
        } else {
          RestClient.service
              .createUserInformationFromTwitchUser(
            Registry.twitchUser!.id,
            Registry.twitchUser!.login,
            Registry.twitchUser!.displayName,
            Registry.twitchUser!.email,
            Registry.twitchUser!.description,
            Registry.twitchUser!.profileImageUrl,
          )
              .then((value) {
            if (value.success) {
              Registry.apiUser = value.response;

              completer.complete(GenericResponse<ApiUser>(success: true, response: Registry.apiUser));
            } else {
              completer.complete(GenericResponse<ApiUser>(success: false));
            }
          }).catchError((error) {
            completer.completeError(error);
          });
        }
      }).catchError((error) {
        completer.completeError(error);
      });
    } else {
      completer.complete(GenericResponse<ApiUser>(success: false, message: "Registry.firebaseUser or Registry.twitchUser is null"));
    }

    return completer.future;
  }

  static Future<GenericResponse<List<ApiUser>>> updateUserFollowings() {
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
      completer.complete(GenericResponse<List<ApiUser>>(success: false, message: "Registry.apiUser is null"));
    }

    return completer.future;
  }
}
