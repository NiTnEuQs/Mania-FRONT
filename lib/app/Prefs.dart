import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Prefs {
  static String twitchAccessToken = "TwitchAccessToken";
  static String twitchRefreshToken = "TwitchRefreshToken";
  static String twitchTokenType = "TwitchTokenType";
  static String twitchExpiresIn = "TwitchExpiresIn";

  static Future<SharedPreferences> initialize() async {
    prefs = await SharedPreferences.getInstance();

    return prefs;
  }
}
