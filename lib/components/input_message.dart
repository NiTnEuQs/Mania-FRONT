import 'package:flutter/material.dart';
import 'package:mania/components/bloc.dart';
import 'package:mania/components/roundedoutline.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class InputMessage extends StatefulWidget {
  InputMessage({
    Key? key,
    this.value,
    this.placeholder,
    this.enabled,
    this.isPassword,
    this.autoFocus,
    this.controller,
    this.onPressed,
    this.onFocus,
    this.onSendMessagePressed,
  });

  final String? value;
  final String? placeholder;
  final bool? enabled, isPassword, autoFocus;
  final TextEditingController? controller;
  final VoidCallback? onPressed;
  final Function(bool)? onFocus;
  final Function(String?)? onSendMessagePressed;

  @override
  State<InputMessage> createState() => _InputMessageState(this.controller);
}

class _InputMessageState extends State<InputMessage> {
  _InputMessageState(this._controller);

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Bloc(
          shadow: true,
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 50),
          onTap: widget.onPressed,
          child: TextField(
            autofocus: widget.autoFocus ?? false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            enabled: widget.enabled ?? true,
            decoration: InputDecoration(
              hintText: widget.placeholder ?? '',
              hintStyle: TextStyle(
                color: Colours.hint,
              ),
              fillColor: Colors.white,
              filled: true,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
            ),
            obscureText: widget.isPassword ?? false,
            controller: _controller,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: Dimens.margin, bottom: Dimens.margin, right: Dimens.margin),
              child: RoundedOutline(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(Dimens.margin),
                onPressed: () {
                  if (widget.onSendMessagePressed != null) {
                    widget.onSendMessagePressed!(_controller?.value.text);
                  }
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
