import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class GreyInput extends StatefulWidget {
  GreyInput({Key? key, this.value, this.placeholder, this.isPassword});

  final String? value;
  final String? placeholder;
  final bool? isPassword;

  @override
  State<GreyInput> createState() => _GreyInputState();
}

class _GreyInputState extends State<GreyInput> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(
      text: widget.value ?? '',
    );

    return TextField(
      decoration: InputDecoration(
        hintText: widget.placeholder ?? '',
        hintStyle: TextStyle(
          color: Colours.hint,
        ),
        fillColor: Colours.greyInput,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.greyInputCornerRadius)),
        ),
      ),
      obscureText: widget.isPassword ?? false,
      controller: _controller,
    );
  }
}
