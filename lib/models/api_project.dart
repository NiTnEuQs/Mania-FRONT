import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_project.g.dart';

@JsonSerializable()
class ApiProject {
  ApiProject({
    required this.id,
    required this.title,
    this.color,
  });

  factory ApiProject.fromJson(Map<String, dynamic> json) => _$ApiProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ApiProjectToJson(this);

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'color', ignore: true)
  Color? color;
}
