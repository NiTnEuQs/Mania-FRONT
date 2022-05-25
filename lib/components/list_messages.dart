import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/message.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/resources/dimensions.dart';

class ListMessages extends BaseStatelessWidget {
  ListMessages(
    this.messages, {
    Key? key,
    this.controller,
    this.displayAvatar,
    this.displayPseudo,
    this.onMessagePressed,
    this.onUserPressed,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(Dimens.margin),
    this.separationHeight = Dimens.marginDouble,
  }) : super(key: key);

  final List<ApiMessage>? messages;
  final ScrollController? controller;
  final bool? displayAvatar;
  final bool? displayPseudo;
  final Function(ApiMessage)? onMessagePressed;
  final Function(ApiUser)? onUserPressed;

  // Design
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? separationHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return ((messages?.length ?? 0) <= 0)
    //     ? Container()
    return ListView.separated(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: separationHeight),
      itemCount: messages?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final ApiMessage message = messages![index];

        return Message(
          message,
          onMessagePressed: (ApiMessage message) {
            if (onMessagePressed != null) {
              onMessagePressed!(message);
            } else {
              defaultOnMessagePressed(context, message);
            }
          },
          onUserPressed: (ApiUser user) {
            if (onUserPressed != null) {
              onUserPressed!(user);
            } else {
              defaultOnUserPressed(context, user);
            }
          },
          displayAvatar: displayAvatar,
          displayPseudo: displayPseudo,
        );
      },
    );
  }

  void defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, '/profile', arguments: user);
  }

  void defaultOnMessagePressed(BuildContext context, ApiMessage message) {
    Navigator.pushNamed(context, "/message", arguments: message);
  }
}
