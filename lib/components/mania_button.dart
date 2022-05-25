import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/resources/dimensions.dart';

class ManiaButton extends BaseStatelessWidget {
  ManiaButton(
    this.text, {
    Key? key,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.inversed,
  }) : super(key: key);

  final String? text;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final bool? inversed;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? 165,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonCornerRadius),
          ),
        ),
        child: ManiaText(
          text ?? "",
          style: TextStyle(
            color: textColor ?? Theme.of(context).textTheme.bodyText2?.color,
          ),
        ),
      ),
    );
  }
}
