import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime toCorrectLocal() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(toString(), true).toLocal();
  }

  String toCorrectFormat() {
    return DateFormat.yMd().add_Hm().format(this);
  }
}
