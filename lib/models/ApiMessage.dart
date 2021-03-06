import 'package:json_annotation/json_annotation.dart';
import 'package:mania/models/ApiUser.dart';

part 'ApiMessage.g.dart';

@JsonSerializable()
class ApiMessage {
  ApiMessage({
    required this.id,
    this.parentMessageId,
    required this.text,
    required this.user,
    this.nbComments,
    this.nbViews,
    required this.timestamp,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'parent_message_id')
  int? parentMessageId;
  @JsonKey(name: 'text')
  String text;
  @JsonKey(name: 'user')
  ApiUser user;
  @JsonKey(name: 'nb_comments')
  int? nbComments;
  @JsonKey(name: 'nb_views')
  int? nbViews;
  @JsonKey(name: 'created_at')
  DateTime timestamp;

  bool hasParent() {
    return parentMessageId != null;
  }

  factory ApiMessage.fromJson(Map<String, dynamic> json) => _$ApiMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMessageToJson(this);
}
