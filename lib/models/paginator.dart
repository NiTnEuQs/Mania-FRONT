import 'package:json_annotation/json_annotation.dart';

part 'paginator.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginator<T> {
  Paginator({
    this.currentPage,
    this.lastPage,
    this.data,
    this.path,
    this.firstPageUrl,
    this.nextPageUrl,
    this.lastPageUrl,
    this.from,
    this.to,
    this.perPage,
  });

  factory Paginator.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$PaginatorFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PaginatorToJson(this, toJsonT);

  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'data')
  List<T>? data;
  @JsonKey(name: 'path')
  String? path;
  @JsonKey(name: 'first_page_url')
  String? firstPageUrl;
  @JsonKey(name: 'last_page_url')
  String? lastPageUrl;
  @JsonKey(name: 'prev_page_url')
  String? prevPageUrl;
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  @JsonKey(name: 'from')
  int? from;
  @JsonKey(name: 'to')
  int? to;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'total')
  int? total;

  bool get hasNextPage => (currentPage ?? 0) < (lastPage ?? 0);

  int get nextPage => (currentPage ?? 0) + 1;
}
