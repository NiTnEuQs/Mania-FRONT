import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  WhiteButton(this.text, {Key? key, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 40,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
