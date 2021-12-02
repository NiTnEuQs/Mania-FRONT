extension IntegerExtension on int {
  String shortify() {
    int value = this;

    if (value >= 1000000000) return '${(value / 1000000000).toStringAsFixed(2)}M';
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(2)}m';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(2)}k';

    return '$value';
  }
}
