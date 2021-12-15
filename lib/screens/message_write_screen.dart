import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/input_message.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class MessageWriteScreen extends StatefulWidget {
  const MessageWriteScreen({Key? key, this.parentMessageId}) : super(key: key);

  final int? parentMessageId;

  @override
  _MessageWriteScreenState createState() => _MessageWriteScreenState();
}

class _MessageWriteScreenState extends State<MessageWriteScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ManiaBar(
        title: trans(context)!.text_publication,
        leftItem: ManiaBarItem.back(context),
      ),
      body: Background(
        shouldCountBar: true,
        padding: const EdgeInsets.symmetric(vertical: Dimens.margin, horizontal: Dimens.margin),
        child: Column(
          children: [
            MaterialHero(
              tag: HeroTags.MESSAGE_WRITE_FIELD,
              child: InputMessage(
                controller: _controller,
                autoFocus: true,
                placeholder: trans(context)!.placeholder_writeYourMessage,
                onSendMessagePressed: onPublishPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPublishPressed(String? message) {
    if (Registry.apiUser != null) {
      RestClient.service.publishMessage(Registry.apiUser!.id, _controller.text, parentMessageId: widget.parentMessageId).then((value) {
        if (value.success) {
          Navigator.pop(context);
        }
      });
    }
  }
}
