import 'package:flutter/material.dart';
import 'package:mania/theme/style.dart';

class StrokyString extends StatelessWidget {
  StrokyString(this._text, {Key? key, this.color, this.textColor, this.inIndent, this.outIndent});

  final String _text;
  final Color? color, textColor;
  final double? inIndent, outIndent;

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
        Text(_text, style: text(color: color ?? Colors.white)),
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
