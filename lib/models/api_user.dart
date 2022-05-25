import 'package:json_annotation/json_annotation.dart';

part 'api_user.g.dart';

@JsonSerializable()
class ApiUser {
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

  factory ApiUser.fromJson(Map<String, dynamic> json) => _$ApiUserFromJson(json);

  Map<String, dynamic> toJson() => _$ApiUserToJson(this);

  static ApiUser empty = ApiUser(id: 0, identifier: "", pseudo: "", bio: "");

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

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! ApiUser) return false;

    return id == other.id;
  }
}
