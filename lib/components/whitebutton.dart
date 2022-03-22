import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton(this.text, {Key? key, this.width, this.height, this.color, this.textColor, this.onPressed});

  final String text;
  final double? width, height;
  final Color? color, textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 165,
        height: height ?? 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.white,
            onPrimary: textColor ?? Colours.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.primary),
          ),
        )
        // child: RaisedButton(
        //   onPressed: onPressed,
        //   color: color ?? Colors.white,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   child: Text(
      //     text,
        //     style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.primary),
        //   ),
        // ),
        );
  }
}
