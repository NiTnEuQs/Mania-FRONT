import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:flutter_twitch_auth/flutter_twitch_auth.dart';
import 'package:mania/api/TwitchClient.dart';
import 'package:mania/app/Const.dart';
import 'package:mania/app/Prefs.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/utils/StringUtils.dart';

class TwitchHandler {
  static Future<bool> initialize({required BuildContext context}) {
    FlutterTwitchAuth.initialize(
      twitchClientId: Const.twitchClientId,
      twitchClientSecret: Const.twitchClientSecret,
      twitchRedirectUri: Const.twitchRedirectUri,
    );

    String twitchAccessToken = prefs.getString(Prefs.twitchAccessToken) ?? "";

    return loginToTwitchWithAccessToken(twitchAccessToken);
  }

  static Future<String?> showTwitchModal({required BuildContext context}) {
    return FlutterTwitchAuth.authToCode(context);
  }

  static Future<AuthResponse?> loginToTwitchWithCode(String? twitchCode) {
    var completer = Completer<AuthResponse?>();

    if (!isStringEmpty(twitchCode)) {
      print("Log into twitch with code $twitchCode");
      FlutterTwitch.users.auth(twitchCode!).then((authResponse) {
        prefs.setString(Prefs.twitchAccessToken, authResponse.accessToken);
        prefs.setString(Prefs.twitchRefreshToken, authResponse.refreshToken ?? "");
        // prefs.setString(Prefs.twitchTokenType, value.tokenType ?? "");
        // prefs.setInt(Prefs.twitchExpiresIn, value.expiresIn);

        completer.complete(authResponse);
      }).catchError((error) {
        int? statusCode = error.response.statusCode;

        print("Error Twitch auth (code: $statusCode)");

        completer.completeError(error);
      });
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  static Future<bool> loginToTwitchWithAccessToken(String? twitchAccessToken) {
    var completer = Completer<bool>();

    if (!isStringEmpty(twitchAccessToken)) {
      print("Log into twitch with access token $twitchAccessToken");
      FlutterTwitch.users.getUsersByToken(twitchAccessToken!).then((apiResponseUser) {
        Registry.twitchUser = apiResponseUser.data.first;

        completer.complete(true);
      }).catchError((error) {
        int? statusCode = error.response.statusCode;

        print("Error Twitch getUsersByToken (code: $statusCode)");
        // print(error);

        bool isTokenExpired = statusCode == 401;

        if (isTokenExpired) {
          refreshTwitchAccessToken().then((value) {
            completer.complete(true);
          }).catchError((error) {
            completer.completeError(error);
            // }).whenComplete(() {
            //   completer.complete(null);
          });
        }
      });
    } else {
      completer.complete(false);
    }

    return completer.future;
  }

  static Future<bool> refreshTwitchAccessToken() {
    var completer = Completer<bool>();

    String twitchRefreshToken = prefs.getString(Prefs.twitchRefreshToken) ?? "";

    print("Refresh access token with refresh token $twitchRefreshToken");
    TwitchClient.service.refreshToken(twitchRefreshToken).then((authResponse) {
      prefs.setString(Prefs.twitchAccessToken, authResponse.accessToken);
      prefs.setString(Prefs.twitchRefreshToken, authResponse.refreshToken ?? "");
      // prefs.setString(Prefs.twitchTokenType, value.tokenType ?? "");
      // prefs.setInt(Prefs.twitchExpiresIn, value.expiresIn);

      loginToTwitchWithAccessToken(authResponse.accessToken).then((value) {
        completer.complete(true);
      }).catchError((error) {
        int? statusCode = error.response.statusCode;

        print("Error Twitch refresh token (code: $statusCode)");

        completer.completeError(error);
      });
    }).catchError((error) {
      int? statusCode = error.response.statusCode;

      print("Error Twitch refresh token (code: $statusCode)");

      completer.completeError(error);
    });

    return completer.future;
  }
}
