import 'package:flutter/material.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/input_message.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';

class MessageWriteScreen extends BaseStatefulWidget {
  const MessageWriteScreen({Key? key, this.parentMessageId}) : super(key: key);

  final int? parentMessageId;

  @override
  _MessageWriteScreenState createState() => _MessageWriteScreenState();
}

class _MessageWriteScreenState extends BaseState<MessageWriteScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: ManiaBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.margin, horizontal: Dimens.margin),
        child: Column(
          children: [
            MaterialHero(
              tag: HeroTags.messageWriteField,
              child: InputMessage(
                controller: _controller,
                autoFocus: true,
                placeholder: trans(context)?.placeholder_writeYourMessage,
                onSendMessagePressed: onPublishPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPublishPressed(String? message) {
    if (Registry.apiUser != null) {
      RestClient.service.publishMessage(Registry.apiUser!.id, _controller.text, parentMessageId: widget.parentMessageId).then((value) {
        if (value.success) {
          Navigator.pop(context);
        }
      });
    }
  }
}
