import 'package:flutter/material.dart';
import 'package:mania/components/input_message.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/hero_tags.dart';

class Writer extends BaseStatefulWidget {
  const Writer({
    this.parentMessageId,
    this.openExtendedWriter,
    this.controller,
    this.onSendMessagePressed,
  });

  final int? parentMessageId;
  final bool? openExtendedWriter;
  final TextEditingController? controller;
  final Function(String?)? onSendMessagePressed;

  @override
  _WriterState createState() => _WriterState();
}

class _WriterState extends BaseState<Writer> {
  _WriterState();

  TextEditingController? _sendMessageController;

  @override
  void initState() {
    super.initState();

    _sendMessageController = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialHero(
      tag: HeroTags.messageWriteField,
      child: InputMessage(
        controller: _sendMessageController,
        enabled: !(widget.openExtendedWriter ?? false),
        onPressed: (widget.openExtendedWriter ?? false)
            ? () {
                Navigator.pushNamed(context, "/message/write", arguments: widget.parentMessageId);
              }
            : null,
        onSendMessagePressed: widget.onSendMessagePressed,
        placeholder: trans(context)?.placeholder_writeYourMessage,
      ),
    );
  }
}
