import 'package:json_annotation/json_annotation.dart';

part 'NoResponse.g.dart';

@JsonSerializable()
class NoResponse {
  NoResponse();

  factory NoResponse.fromJson(Map<String, dynamic> json) => _$NoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoResponseToJson(this);
}
