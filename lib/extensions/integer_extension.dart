extension IntegerExtension on int {
  String shortify() {
    if (this >= 1000000000) return '${(this / 1000000000).toStringAsFixed(2)}M';
    if (this >= 1000000) return '${(this / 1000000).toStringAsFixed(2)}m';
    if (this >= 1000) return '${(this / 1000).toStringAsFixed(2)}k';

    return '$this';
  }
}
