import 'package:json_annotation/json_annotation.dart';

part 'GenericResponse.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericResponse<T> {
  GenericResponse({
    required this.success,
    this.message,
    this.response,
  });

  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'response')
  T? response;

  factory GenericResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$GenericResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$GenericResponseToJson(this, toJsonT);
}
