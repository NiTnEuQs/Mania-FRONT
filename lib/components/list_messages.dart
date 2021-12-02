import 'package:flutter/material.dart';
import 'package:mania/components/message.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';

class ListMessages extends BaseStatelessWidget {
  ListMessages(this.messages, {Key? key, this.displayAvatar, this.displayPseudo, this.onMessagePressed, this.onUserPressed});

  final List<ApiMessage>? messages;
  final bool? displayAvatar, displayPseudo;
  final Function(ApiMessage)? onMessagePressed;
  final Function(ApiUser)? onUserPressed;

  @override
  Widget build(BuildContext context) {
    return (messages?.length ?? 0) <= 0
        ? Center(child: Text(trans(context)!.text_noMessage))
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: messages?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              ApiMessage message = messages![index];

              return Message(
                message,
                onMessagePressed: onMessagePressed,
                onUserPressed: onUserPressed,
                displayAvatar: displayAvatar,
                displayPseudo: displayPseudo,
              );
            },
          );
  }
}
