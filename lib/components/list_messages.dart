import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/input_message.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/message.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class ListMessages extends BaseStatelessWidget {
  ListMessages(
    this.messages, {
    Key? key,
    this.noDataColor = Colors.white,
    this.controller,
    this.parentMessageId,
    this.displayAvatar,
    this.displayPseudo,
    this.displayWriteAMessage,
    this.openExtendedWriter,
    this.sendMessageController,
    this.onMessagePressed,
    this.onUserPressed,
    this.onSendMessagePressed,
  });

  final List<ApiMessage>? messages;
  final Color noDataColor;
  final ScrollController? controller;
  final int? parentMessageId;
  final bool? openExtendedWriter, displayAvatar, displayPseudo, displayWriteAMessage;
  final TextEditingController? sendMessageController;
  final Function(ApiMessage)? onMessagePressed;
  final Function(ApiUser)? onUserPressed;
  final Function(String?)? onSendMessagePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (messages?.length ?? 0) <= 0
        ? Column(
            children: [
              if ((displayWriteAMessage ?? false)) inputMessage(context),
              Expanded(
                child: Center(
                  child: WhiteText(
                    trans(context)!.text_noMessage,
                    color: noDataColor,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            controller: controller,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: (messages?.length ?? 0 + ((displayWriteAMessage ?? false) ? 1 : 0)),
            itemBuilder: (BuildContext context, int index) {
              ApiMessage message = messages![index];

              return Column(
                children: [
                  if ((displayWriteAMessage ?? false) && index == 0) inputMessage(context),
                  Message(
                    message,
                    onMessagePressed: (ApiMessage message) {
                      if (onMessagePressed != null)
                        onMessagePressed!(message);
                      else
                        defaultOnMessagePressed(context, message);
                    },
                    onUserPressed: (ApiUser user) {
                      if (onUserPressed != null)
                        onUserPressed!(user);
                      else
                        defaultOnUserPressed(context, user);
                    },
                    displayAvatar: displayAvatar,
                    displayPseudo: displayPseudo,
                  ),
                ],
              );
            },
          );
  }

  defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, '/profile', arguments: user);
  }

  defaultOnMessagePressed(BuildContext context, ApiMessage message) {
    Navigator.pushNamed(context, "/message", arguments: message);
  }

  Widget inputMessage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.halfMargin),
      child: MaterialHero(
        tag: HeroTags.MESSAGE_WRITE_FIELD,
        child: InputMessage(
          controller: sendMessageController,
          enabled: !(openExtendedWriter ?? false),
          onPressed: (openExtendedWriter ?? false)
              ? () {
                  Navigator.pushNamed(context, "/message/write", arguments: parentMessageId);
                }
              : null,
          onSendMessagePressed: onSendMessagePressed,
          placeholder: trans(context)!.placeholder_writeYourMessage,
        ),
      ),
    );
  }
}
