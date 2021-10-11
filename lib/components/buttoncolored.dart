import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  ColoredButton({Key? key, this.onPressed, this.text});

  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text ?? ''),
    );
  }
}
