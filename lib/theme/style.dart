import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

TextStyle title({fontSize, color, bold}) {
  return TextStyle(
    fontSize: fontSize ?? Dimens.titleSize,
    color: color ?? Colours.text,
    fontWeight: bold ?? FontWeight.w400,
  );
}

TextStyle titleThin() {
  return title(
    fontSize: Dimens.titleSize,
    color: Colours.text,
    bold: FontWeight.w200,
  );
}

// --------------------------------------------------

TextStyle text({fontSize, color, bold}) {
  return TextStyle(
    fontSize: fontSize ?? Dimens.textSize,
    color: color ?? Colours.text,
    fontWeight: bold ?? FontWeight.w400,
  );
}
