import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/theme/style.dart';

class WhiteText extends StatelessWidget {
  WhiteText(this._text,
      {Key? key, this.onPressed, this.textAlign, this.style, this.color, this.fontSize, this.thin, this.bold, this.bolder, this.boldest});

  final String _text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final bool? thin, bold, bolder, boldest;
  final TextAlign? textAlign;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      textAlign: textAlign ?? TextAlign.start,
      style: style ??
          text(
              color: color ?? Colors.white,
              fontSize: fontSize ?? Dimens.textSize,
              bold: (boldest ?? false
                  ? FontWeight.w900
                  : (bolder ?? false
                      ? FontWeight.w700
                      : (bold ?? false ? FontWeight.w500 : (thin ?? false ? FontWeight.w200 : FontWeight.w400))))),
    );
  }
}
