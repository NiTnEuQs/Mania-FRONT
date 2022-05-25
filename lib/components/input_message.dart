import 'package:flutter/material.dart';
import 'package:mania/components/rounded_button.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({
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
  final bool? enabled;
  final bool? isPassword;
  final bool? autoFocus;
  final TextEditingController? controller;
  final VoidCallback? onPressed;
  final Function(bool)? onFocus;
  final Function(String?)? onSendMessagePressed;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  _InputMessageState();

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedContainer(
          padding: const EdgeInsets.only(right: 50),
          color: Theme.of(context).backgroundColor,
          onPressed: widget.onPressed,
          child: TextField(
            autofocus: widget.autoFocus ?? false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            enabled: widget.enabled ?? true,
            decoration: InputDecoration(
              hintText: widget.placeholder ?? '',
              hintStyle: const TextStyle(
                color: Colours.hint,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.blocCornerRadius)),
              ),
              border: const OutlineInputBorder(
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
              child: RoundedContainer(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(Dimens.margin),
                onPressed: () {
                  if (widget.onSendMessagePressed != null) {
                    widget.onSendMessagePressed!(_controller?.value.text)!;
                  }
                },
                child: const Icon(
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
