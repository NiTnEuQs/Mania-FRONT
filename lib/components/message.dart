import 'package:flutter/material.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/rounded_button.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/extensions/date_time_extension.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message extends BaseStatefulWidget {
  const Message(
    this.message, {
    this.extended = false,
    this.displayAvatar = false,
    this.displayPseudo = false,
    this.displayNbComments = true,
    this.displayNbViews = false,
    this.displayTimestamp = true,
    this.onMessagePressed,
    this.onUserPressed,
  });

  final ApiMessage message;
  final bool extended;
  final bool? displayAvatar;
  final bool? displayPseudo;
  final bool? displayNbComments;
  final bool? displayNbViews;
  final bool? displayTimestamp;
  final Function(ApiMessage)? onMessagePressed;
  final Function(ApiUser)? onUserPressed;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends BaseState<Message> {
  @override
  Widget build(BuildContext context) {
    final String _messageDate =
        widget.extended ? widget.message.timestamp.toCorrectLocal().toCorrectFormat() : timeago.format(widget.message.timestamp.toCorrectLocal());

    return RoundedContainer(
      onPressed: (widget.onMessagePressed != null) ? () => widget.onMessagePressed!(widget.message) : null,
      color: widget.extended ? Colors.transparent : Theme.of(context).backgroundColor,
      padding: widget.extended ? EdgeInsets.zero : const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if ((widget.displayAvatar ?? true) || (widget.displayPseudo ?? true))
            RoundedContainer(
              radius: 50,
              color: Colors.transparent,
              onPressed: () {
                if (widget.onUserPressed != null) {
                  widget.onUserPressed!(widget.message.user);
                } else {
                  defaultOnUserPressed(context, widget.message.user);
                }
              },
              child: Row(
                children: [
                  if (widget.displayAvatar ?? true)
                    MaterialHero(
                      tag: widget.extended ? '${HeroTags.profileAvatar}${widget.message.user.id}' : '${HeroTags.messageAvatar}${widget.message.id}',
                      child: RoundedImage(
                        widget.message.user.imageUrl,
                        width: widget.extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        height: widget.extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        isUrl: true,
                      ),
                    ),
                  const SizedBox(width: Dimens.margin),
                  if (widget.displayPseudo ?? true)
                    Expanded(
                      child: MaterialHero(
                        tag: widget.extended ? '${HeroTags.profilePseudo}${widget.message.user.id}' : '${HeroTags.messagePseudo}${widget.message.id}',
                        child: ManiaText(
                          widget.message.user.pseudo,
                          boldest: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(height: (widget.displayAvatar ?? true) || (widget.displayPseudo ?? true) ? Dimens.marginDouble : 0),
          MaterialHero(
            tag: '${HeroTags.messageText}${widget.message.id}',
            child: ManiaText(
              widget.message.text,
              fontDimension: widget.extended ? TextDimension.xxl : null,
            ),
          ),
          const SizedBox(height: Dimens.marginDouble),
          if ((widget.displayNbComments ?? true) || (widget.displayTimestamp ?? true))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (widget.displayNbComments ?? true)
                  MaterialHero(
                    tag: '${HeroTags.messageNbComments}${widget.message.id}',
                    child: ManiaText(
                      trans(context)?.comment(widget.message.nbComments ?? 0),
                      color: Colors.grey,
                      fontDimension: TextDimension.xs,
                      bold: true,
                    ),
                  ),
                if (widget.displayNbViews ?? true)
                  MaterialHero(
                    tag: '${HeroTags.messageNbViews}${widget.message.id}',
                    child: ManiaText(
                      trans(context)?.view(widget.message.nbViews ?? 0),
                      color: Colors.grey,
                      fontDimension: TextDimension.xs,
                      bold: true,
                    ),
                  ),
                if (widget.displayTimestamp ?? true)
                  MaterialHero(
                    tag: '${HeroTags.messageTimestamp}${widget.message.id}',
                    child: ManiaText(
                      _messageDate,
                      color: Colors.grey,
                      fontDimension: TextDimension.xs,
                      bold: true,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  void defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, '/profile', arguments: user);
  }
}
