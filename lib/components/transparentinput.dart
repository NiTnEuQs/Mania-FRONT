import 'package:flutter/material.dart';
import 'package:mania/resources/colours.dart';

class TransparentInput extends StatefulWidget {
  TransparentInput({
    Key? key,
    this.value,
    this.placeholder,
    this.keyboardType,
    this.color,
    this.minLines,
    this.maxLines,
    this.expands,
    this.isPassword,
    this.autofocus,
    this.controller,
    this.onValueChanged,
  });

  final String? value;
  final String? placeholder;
  final TextInputType? keyboardType;
  final Color? color;
  final int? minLines, maxLines;
  final bool? expands;
  final bool? isPassword;
  final bool? autofocus;
  final TextEditingController? controller;
  final ValueChanged<String>? onValueChanged;

  @override
  State<TransparentInput> createState() => _TransparentInputState();
}

class _TransparentInputState extends State<TransparentInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onValueChanged,
        autofocus: widget.autofocus ?? false,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: widget.placeholder ?? '',
          hintStyle: TextStyle(
            color: Colours.hint,
          ),
          fillColor: widget.color ?? Colors.transparent,
          filled: true,
          border: InputBorder.none,
        ),
        expands: widget.expands ?? false,
        minLines: (widget.expands ?? false)
            ? null
            : (widget.isPassword ?? true)
                ? 1
                : widget.minLines,
        maxLines: (widget.expands ?? false)
            ? null
            : (widget.isPassword ?? true)
                ? 1
                : widget.maxLines,
        obscureText: widget.isPassword ?? false,
        keyboardType: widget.keyboardType,
        // controller: _controller,
      ),
    );
  }
}
