import 'package:freezed_annotation/freezed_annotation.dart';

part 'args_recent_notifications.freezed.dart';

@freezed
class ArgsRecentNotifications with _$ArgsRecentNotifications {
  factory ArgsRecentNotifications(int userId, [
    @Default(1) int page,
  ]) = _ArgsRecentNotifications;
}
