import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class ManiaText extends StatelessWidget {
  const ManiaText(
    this._text, {
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

  const ManiaText.white(
    this._text, {
    this.onPressed,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.style,
    this.color = Colors.white,
    this.fontSize,
    this.thin,
    this.bold,
    this.bolder,
    this.boldest,
    this.fontDimension,
  });

  final String? _text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final TextDimension? fontDimension;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? thin;
  final bool? bold;
  final bool? bolder;
  final bool? boldest;
  final TextAlign? textAlign;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        _text ?? "",
        overflow: overflow,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.start,
        style: style ??
            const TextStyle().copyWith(
              color: color,
              fontSize: fontSize ?? fontDimension?.size ?? Dimens.textSize,
              fontWeight: boldest ?? false
                  ? FontWeight.w900
                  : (bolder ?? false ? FontWeight.w700 : (bold ?? false ? FontWeight.w500 : (thin ?? false ? FontWeight.w200 : FontWeight.w400))),
            ),
      ),
    );
  }
}

enum TextDimension { xxs, xs, s, m, l, xl, xxl }

extension TextDimensionExtension on TextDimension {
  double get size {
    switch (this) {
      case TextDimension.xxs:
        return 10;
      case TextDimension.xs:
        return 12;
      case TextDimension.s:
        return 14;
      case TextDimension.m:
        return 16;
      case TextDimension.l:
        return 18;
      case TextDimension.xl:
        return 20;
      case TextDimension.xxl:
        return 22;
    }
  }
}
