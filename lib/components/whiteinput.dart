import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class WhiteInput extends StatelessWidget {
  WhiteInput({Key? key, this.value, this.placeholder, this.isPassword});

  final String? value;
  final String? placeholder;
  final bool? isPassword;

  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(
      text: value ?? '',
    );

    return Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder ?? '',
          hintStyle: TextStyle(
            color: Colours.hint,
          ),
          fillColor: Colours.whiteInput,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.greyInputCornerRadius)),
          ),
        ),
        obscureText: isPassword ?? false,
        controller: _controller,
      ),
    );
  }
}
