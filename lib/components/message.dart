import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/bloc.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/extensions/DateTimeExtension.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message extends StatefulWidget {
  Message(
    this.message, {
    Key? key,
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
  final bool? displayAvatar, displayPseudo, displayNbComments, displayNbViews, displayTimestamp;
  final Function(ApiMessage)? onMessagePressed;
  final Function(ApiUser)? onUserPressed;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    String _messageDate =
        widget.extended ? widget.message.timestamp.toCorrectLocal().toCorrectFormat() : timeago.format(widget.message.timestamp.toCorrectLocal());

    return Container(
      color: Colors.transparent,
      padding: widget.extended ? const EdgeInsets.all(0) : const EdgeInsets.all(Dimens.halfMargin),
      child: Bloc(
        onTap: (widget.onMessagePressed != null) ? () => widget.onMessagePressed!(widget.message) : null,
        color: widget.extended ? Colors.transparent : Theme.of(context).backgroundColor,
        shadow: !widget.extended,
        padding: widget.extended ? const EdgeInsets.all(0) : const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if ((widget.displayAvatar ?? true) || (widget.displayPseudo ?? true))
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.displayAvatar ?? true)
                    MaterialHero(
                      tag: widget.extended ? '${HeroTags.PROFILE_AVATAR}${widget.message.user.id}' : '${HeroTags.MESSAGE_AVATAR}${widget.message.id}',
                      child: RoundedImage(
                        widget.message.user.imageUrl,
                        onPressed: () {
                          if (widget.onUserPressed != null)
                            widget.onUserPressed!(widget.message.user);
                          else
                            defaultOnUserPressed(context, widget.message.user);
                        },
                        width: widget.extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        height: widget.extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        isUrl: true,
                      ),
                    ),
                  SizedBox(width: Dimens.margin),
                  if (widget.displayPseudo ?? true)
                    Expanded(
                      child: MaterialHero(
                        tag: widget.extended ? '${HeroTags.PROFILE_PSEUDO}${widget.message.user.id}' : '${HeroTags.MESSAGE_PSEUDO}${widget.message.id}',
                        child: WhiteText(
                          widget.message.user.pseudo,
                          onPressed: widget.onUserPressed != null ? () => widget.onUserPressed!(widget.message.user) : null,
                          color: widget.extended ? Colors.white : Theme.of(context).textTheme.headline6?.color,
                          boldest: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            SizedBox(height: (widget.displayAvatar ?? true) || (widget.displayPseudo ?? true) ? Dimens.marginDouble : 0),
            MaterialHero(
              tag: '${HeroTags.MESSAGE_TEXT}${widget.message.id}',
              child: WhiteText(
                widget.message.text,
                color: widget.extended ? Colors.white : Theme.of(context).textTheme.bodyText1?.color,
                fontDimension: widget.extended ? TextDimension.XXL : null,
              ),
            ),
            SizedBox(height: Dimens.marginDouble),
            if ((widget.displayNbComments ?? true) || (widget.displayTimestamp ?? true))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.displayNbComments ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_NB_COMMENTS}${widget.message.id}',
                      child: WhiteText(
                        trans(context)!.comment(widget.message.nbComments ?? 0),
                        color: widget.extended ? Colors.white : Colors.grey,
                        fontDimension: TextDimension.XS,
                        bold: true,
                      ),
                    ),
                  if (widget.displayNbViews ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_NB_VIEWS}${widget.message.id}',
                      child: WhiteText(
                        trans(context)!.view(widget.message.nbViews ?? 0),
                        color: widget.extended ? Colors.white : Colors.grey,
                        fontDimension: TextDimension.XS,
                        bold: true,
                      ),
                    ),
                  if (widget.displayTimestamp ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_TIMESTAMP}${widget.message.id}',
                      child: WhiteText(
                        _messageDate,
                        color: widget.extended ? Colors.white : Colors.grey,
                        fontDimension: TextDimension.XS,
                        bold: true,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  defaultOnUserPressed(BuildContext context, ApiUser user) {
    Navigator.pushNamed(context, '/profile', arguments: user);
  }
}
