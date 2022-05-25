import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/rest_client.dart';

final apiProvider = Provider<RestClient>((ref) {
  return RestClient.service;
});
