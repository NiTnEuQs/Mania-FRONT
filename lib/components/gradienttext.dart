import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/theme/style.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this._text, {
    Key? key,
    this.onPressed,
    this.gradient,
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
  });

  final String? _text;
  final Gradient? gradient;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? thin, bold, bolder, boldest;
  final TextAlign? textAlign;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          _text ?? "",
          overflow: overflow,
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.start,
          style: style ??
              text(
                  color: color ?? Colors.white,
                  fontSize: fontSize ?? Dimens.textSize,
                  bold: (boldest ?? false
                      ? FontWeight.w900
                      : (bolder ?? false ? FontWeight.w700 : (bold ?? false ? FontWeight.w500 : (thin ?? false ? FontWeight.w200 : FontWeight.w400))))),
        ),
      ),
    );
  }
}
