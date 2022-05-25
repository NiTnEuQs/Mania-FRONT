import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class WhiteInput extends StatefulWidget {
  const WhiteInput({this.value, this.placeholder, this.maxLines, this.isPassword});

  final String? value;
  final String? placeholder;
  final int? maxLines;
  final bool? isPassword;

  @override
  State<WhiteInput> createState() => _WhiteInputState();
}

class _WhiteInputState extends State<WhiteInput> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(
      text: widget.value ?? '',
    );

    return SizedBox(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
          hintText: widget.placeholder ?? '',
          hintStyle: const TextStyle(
            color: Colours.hint,
          ),
          fillColor: Colours.whiteInput,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.greyInputCornerRadius)),
          ),
        ),
        maxLines: (widget.isPassword ?? true) ? 1 : widget.maxLines,
        obscureText: widget.isPassword ?? false,
        controller: _controller,
      ),
    );
  }
}
