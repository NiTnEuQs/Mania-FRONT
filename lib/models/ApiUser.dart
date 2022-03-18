import 'package:json_annotation/json_annotation.dart';

part 'ApiUser.g.dart';

@JsonSerializable()
class ApiUser {
  static var empty = ApiUser(id: 0, identifier: "", pseudo: "", bio: "");

  ApiUser({
    required this.id,
    required this.identifier,
    required this.pseudo,
    required this.bio,
    this.imageUrl,
    this.nbFollowings,
    this.nbFollowers,
    this.tags,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'identifier')
  String identifier;
  @JsonKey(name: 'pseudo')
  String pseudo;
  @JsonKey(name: 'bio')
  String bio;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'nb_messages')
  int? nbMessages;
  @JsonKey(name: 'nb_followings')
  int? nbFollowings;
  @JsonKey(name: 'nb_followers')
  int? nbFollowers;
  @JsonKey(name: 'tags')
  List<String>? tags;

  factory ApiUser.fromJson(Map<String, dynamic> json) => _$ApiUserFromJson(json);

  Map<String, dynamic> toJson() => _$ApiUserToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (!(other is ApiUser)) return false;

    return this.id == other.id;
  }
}
