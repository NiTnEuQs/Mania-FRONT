import 'package:json_annotation/json_annotation.dart';

part 'api_relation.g.dart';

@JsonSerializable()
class ApiRelation {
  ApiRelation({
    required this.id,
    required this.followerId,
    required this.userId,
    required this.followed,
    required this.blocked,
  });

  factory ApiRelation.fromJson(Map<String, dynamic> json) => _$ApiRelationFromJson(json);

  Map<String, dynamic> toJson() => _$ApiRelationToJson(this);

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'follower_id')
  int followerId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'followed', fromJson: _boolFromInt, toJson: _boolToInt)
  bool followed;
  @JsonKey(name: 'blocked', fromJson: _boolFromInt, toJson: _boolToInt)
  bool blocked;

  static bool _boolFromInt(int value) => value == 1;

  static int _boolToInt(bool value) => value ? 1 : 0;
}
