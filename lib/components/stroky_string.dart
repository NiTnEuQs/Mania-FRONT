import 'package:flutter/material.dart';

class StrokyString extends StatelessWidget {
  const StrokyString(this._text, {this.color, this.textColor, this.inIndent, this.outIndent});

  final String _text;
  final Color? color;
  final Color? textColor;
  final double? inIndent;
  final double? outIndent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Divider(
            color: color ?? Colors.white,
            indent: outIndent ?? 32.0,
            endIndent: inIndent ?? 16.0,
          ),
        ),
        Text(
          _text,
          style: const TextStyle().copyWith(
            color: color ?? Colors.white,
          ),
        ),
        Expanded(
          child: Divider(
            color: color ?? Colors.white,
            indent: inIndent ?? 16.0,
            endIndent: outIndent ?? 32.0,
          ),
        ),
      ],
    );
  }
}
