import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/theme/style.dart';

class WhiteText extends StatelessWidget {
  WhiteText(
    this._text, {
    Key? key,
    this.onPressed,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.style,
    this.color,
    this.fontSize,
    this.thin,
    this.bold,
    this.bolder,
    this.boldest,
    this.fontDimension,
  });

  final String _text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final TextDimension? fontDimension;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? thin, bold, bolder, boldest;
  final TextAlign? textAlign;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        _text,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            text(
                color: color ?? Colors.white,
                fontSize: fontSize ?? fontDimension?.size ?? Dimens.textSize,
                bold: (boldest ?? false
                    ? FontWeight.w900
                    : (bolder ?? false ? FontWeight.w700 : (bold ?? false ? FontWeight.w500 : (thin ?? false ? FontWeight.w200 : FontWeight.w400))))),
      ),
    );
  }
}

enum TextDimension { XXS, XS, S, M, L, XL, XXL }

extension TextDimensionExtension on TextDimension {
  double get size {
    switch (this) {
      case TextDimension.XXS:
        return 10;
      case TextDimension.XS:
        return 12;
      case TextDimension.S:
        return 14;
      case TextDimension.M:
        return 16;
      case TextDimension.L:
        return 18;
      case TextDimension.XL:
        return 20;
      case TextDimension.XXL:
        return 22;
    }
  }
}
