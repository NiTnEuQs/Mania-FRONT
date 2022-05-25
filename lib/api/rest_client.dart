import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:mania/app/const.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_relation.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/models/generic_response.dart';
import 'package:mania/models/paginator.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static bool verbose = true;
  static RestClient service = RestClient(instantiateDio());

  static Dio instantiateDio() {
    final dio = Dio();
    dio.options.baseUrl = Const.baseUrl;
    dio.options.contentType = "application/json";
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;

    if (verbose) {
      dio.interceptors.add(
        DioLoggingInterceptor(
          level: Level.body,
          compact: false,
        ),
      );
    }

    return dio;
  }

  @POST("users/create")
  Future<GenericResponse<ApiUser>> createUserInformationFromFirebaseUser(
    @Field('firebase_id') String firebaseId,
  );

  @POST("users/create")
  Future<GenericResponse<ApiUser>> createUserInformationFromTwitchUser(
    @Field('twitch_id') String twitchId,
    @Field('identifier') String? identifier,
    @Field('pseudo') String? pseudo,
    @Field('email') String? email,
    @Field('bio') String? bio,
    @Field('avatar') String? profilePictureUrl,
  );

  @POST("users/get")
  Future<GenericResponse<ApiUser>> getUserInformationWithFirebaseId(@Field('firebase_id') String firebaseId);

  @POST("users/get")
  Future<GenericResponse<ApiUser>> getUserInformationWithTwitchId(@Field('twitch_id') String twitchId);

  @POST("users/get")
  Future<GenericResponse<ApiUser>> getUserInformationWithUserId(@Field('user_id') int userId);

  @POST("users/get")
  Future<GenericResponse<List<ApiUser>>> searchUsers(
    @Field('search_value') String? searchValue, {
    @Field('searcher_id') int? searcherId,
  });

  @MultiPart()
  @POST("users/editProfile")
  Future<GenericResponse<ApiUser>> editProfile(
    @Part(name: 'user_id') int userId, {
    @Part(name: 'pseudo') String? pseudo,
    @Part(name: 'bio') String? bio,
    @Part(name: 'avatar') File? avatar,
    @Part(name: 'avatar_url') String? avatarUrl,
  });

  @POST("users/recentNotifications")
  Future<GenericResponse<Paginator<ApiMessage>>> getRecentNotifications(@Field('user_id') int userId, @Query('page') int page);

  @POST("relations/followings")
  Future<GenericResponse<List<ApiUser>>> getUserFollowings(@Field('user_id') int userId);

  @POST("relations/followers")
  Future<GenericResponse<List<ApiUser>>> getUserFollowers(@Field('user_id') int userId);

  @POST("messages/get")
  Future<GenericResponse<List<ApiMessage>>> getUserMessages(@Field('user_id') int userId);

  @POST("messages/get")
  Future<GenericResponse<List<ApiMessage>>> getMessageComments(@Field('parent_message_id') int parentMessageId);

  @POST("relations/update")
  Future<GenericResponse<ApiRelation>> updateRelation(
    @Field('follower_id') int followerId,
    @Field('user_id') int userId, {
    @Field('followed') bool? followed,
    @Field('blocked') bool? blocked,
  });

  @POST("messages/publish")
  Future<GenericResponse<bool>> publishMessage(
    @Field('user_id') int userId,
    @Field('text') String text, {
    @Field('parent_message_id') int? parentMessageId,
  });
}
