import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:flutter_twitch_auth/flutter_twitch_auth.dart';
import 'package:mania/api/twitch_client.dart';
import 'package:mania/app/const.dart';
import 'package:mania/app/prefs.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/utils/string_utils.dart';

class TwitchHandler {
  static Future<bool> initialize() {
    FlutterTwitchAuth.initialize(
      twitchClientId: Const.twitchClientId,
      twitchClientSecret: Const.twitchClientSecret,
      twitchRedirectUri: Const.twitchRedirectUri,
    );

    final String twitchAccessToken = prefs.getString(Prefs.twitchAccessToken) ?? "";

    return loginToTwitchWithAccessToken(twitchAccessToken);
  }

  static Future<String?> showTwitchModal({required BuildContext context}) {
    return FlutterTwitchAuth.authToCode(context);
  }

  static Future<AuthResponse?> loginToTwitchWithCode(String? twitchCode) {
    final completer = Completer<AuthResponse?>();

    if (!isStringEmpty(twitchCode)) {
      if (kDebugMode) {
        print("Log into twitch with code $twitchCode");
      }

      FlutterTwitch.users.auth(twitchCode!).then((authResponse) {
        prefs.setString(Prefs.twitchAccessToken, authResponse.accessToken);
        prefs.setString(Prefs.twitchRefreshToken, authResponse.refreshToken ?? "");
        // prefs.setString(Prefs.twitchTokenType, value.tokenType ?? "");
        // prefs.setInt(Prefs.twitchExpiresIn, value.expiresIn);

        completer.complete(authResponse);
      }).catchError((err) {
        final DioError error = err as DioError;

        final int? statusCode = error.response?.statusCode;

        if (kDebugMode) {
          print("Error Twitch auth (code: $statusCode)");
        }

        completer.completeError(error);
      });
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  static Future<bool> loginToTwitchWithAccessToken(String? twitchAccessToken) {
    final completer = Completer<bool>();

    if (!isStringEmpty(twitchAccessToken)) {
      if (kDebugMode) {
        print("Log into twitch with access token $twitchAccessToken");
      }

      FlutterTwitch.users.getUsersByToken(twitchAccessToken!).then((apiResponseUser) {
        Registry.twitchUser = apiResponseUser.data.first;

        completer.complete(true);
      }).catchError((err) {
        final DioError error = err as DioError;

        final int? statusCode = error.response?.statusCode;

        if (kDebugMode) {
          print("Error Twitch getUsersByToken (code: $statusCode)");
        }

        final bool isTokenExpired = statusCode == 401;

        if (isTokenExpired) {
          refreshTwitchAccessToken().then((value) {
            completer.complete(true);
          }).catchError((err) {
            final DioError error = err as DioError;

            final int? statusCode = error.response?.statusCode;

            if (kDebugMode) {
              print("Error Twitch refreshTwitchAccessToken (code: $statusCode)");
            }

            completer.completeError(error);
          });
        } else {
          completer.completeError(error);
        }
      });
    } else {
      completer.complete(false);
    }

    return completer.future;
  }

  static Future<bool> refreshTwitchAccessToken() {
    final completer = Completer<bool>();

    final String twitchRefreshToken = prefs.getString(Prefs.twitchRefreshToken) ?? "";

    if (kDebugMode) {
      print("Refresh access token with refresh token $twitchRefreshToken");
    }

    TwitchClient.service.refreshToken(twitchRefreshToken).then((authResponse) {
      prefs.setString(Prefs.twitchAccessToken, authResponse.accessToken);
      prefs.setString(Prefs.twitchRefreshToken, authResponse.refreshToken ?? "");
      // prefs.setString(Prefs.twitchTokenType, value.tokenType ?? "");
      // prefs.setInt(Prefs.twitchExpiresIn, value.expiresIn);

      loginToTwitchWithAccessToken(authResponse.accessToken).then((value) {
        completer.complete(true);
      }).catchError((err) {
        final DioError error = err as DioError;

        final int? statusCode = error.response?.statusCode;

        if (kDebugMode) {
          print("Error Twitch refresh token (code: $statusCode)");
        }

        completer.completeError(error);
      });
    }).catchError((err) {
      final DioError error = err as DioError;

      final int? statusCode = error.response?.statusCode;

      if (kDebugMode) {
        print("Error Twitch refresh token (code: $statusCode)");
      }

      completer.completeError(error);
    });

    return completer.future;
  }
}
