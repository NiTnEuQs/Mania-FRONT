import 'package:mania/extensions/integer_extension.dart';

extension StringExtension on String {
  String plurialize(int amount, {bool displayAmount = true, bool shortify = false}) {
    return "${displayAmount ? '${shortify ? amount.shortify() : amount} ' : ''}${this}${amount > 1 ? 's' : ''}";
  }
}
