import 'package:dio/dio.dart';
import 'package:flutter_twitch/flutter_twitch.dart';
import 'package:mania/app/const.dart';
import 'package:retrofit/retrofit.dart';

part 'twitch_client.g.dart';

@RestApi()
abstract class TwitchClient {
  factory TwitchClient(Dio dio, {String baseUrl}) = _TwitchClient;

  static TwitchClient service = TwitchClient(instantiateDio());

  static Dio instantiateDio() {
    final dio = Dio();
    dio.options.baseUrl = Const.twitchBaseUrl;
    dio.options.contentType = "application/json";
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;

    return dio;
  }

  @POST("oauth2/token")
  Future<AuthResponse> refreshToken(
    @Field('refresh_token') String refreshToken, {
    @Field('grant_type') String grantType = 'refresh_token',
    @Field('client_id') String clientId = Const.twitchClientId,
    @Field('client_secret') String clientSecret = Const.twitchClientSecret,
  });
}
