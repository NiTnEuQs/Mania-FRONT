import 'package:flutter/material.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/bloc.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: extended ? const EdgeInsets.all(0) : const EdgeInsets.all(6.0),
      child: Bloc(
        onTap: (onMessagePressed != null) ? () => onMessagePressed!(message) : null,
        color: extended ? Colors.transparent : Colors.white,
        shadow: !extended,
        padding: extended ? const EdgeInsets.all(0) : const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if ((displayAvatar ?? true) || (displayPseudo ?? true))
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (displayAvatar ?? true)
                    MaterialHero(
                      tag: extended ? '${HeroTags.PROFILE_AVATAR}${message.user.id}' : '${HeroTags.MESSAGE_AVATAR}${message.id}',
                      child: RoundedImage(
                        message.user.imageUrl,
                        onPressed: onUserPressed != null ? () => onUserPressed!(message.user) : null,
                        width: extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        height: extended ? Dimens.extendedMessageAvatarSize : Dimens.messageAvatarSize,
                        isUrl: true,
                      ),
                    ),
                  SizedBox(width: Dimens.margin),
                  if (displayPseudo ?? true)
                    Expanded(
                      child: MaterialHero(
                        tag: extended ? '${HeroTags.PROFILE_PSEUDO}${message.user.id}' : '${HeroTags.MESSAGE_PSEUDO}${message.id}',
                        child: WhiteText(
                          message.user.pseudo,
                          onPressed: onUserPressed != null ? () => onUserPressed!(message.user) : null,
                          color: extended ? Colors.white : Colors.black,
                          boldest: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            SizedBox(height: (displayAvatar ?? true) || (displayPseudo ?? true) ? Dimens.marginDouble : 0),
            MaterialHero(
              tag: '${HeroTags.MESSAGE_TEXT}${message.id}',
              child: WhiteText(
                message.text,
                color: extended ? Colors.white : Colors.black,
                fontDimension: extended ? TextDimension.XXL : null,
              ),
            ),
            SizedBox(height: Dimens.marginDouble),
            if ((displayNbComments ?? true) || (displayTimestamp ?? true))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (displayNbComments ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_NB_COMMENTS}${message.id}',
                      child: WhiteText(
                        trans(context)!.comment(message.nbComments ?? 0),
                        color: extended ? Colors.white : Colors.grey,
                        fontDimension: TextDimension.XS,
                        bold: true,
                      ),
                    ),
                  if (displayNbViews ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_NB_VIEWS}${message.id}',
                      child: WhiteText(
                        trans(context)!.view(message.nbViews ?? 0),
                        color: extended ? Colors.white : Colors.grey,
                        fontDimension: TextDimension.XS,
                        bold: true,
                      ),
                    ),
                  if (displayTimestamp ?? true)
                    MaterialHero(
                      tag: '${HeroTags.MESSAGE_TIMESTAMP}${message.id}',
                      child: WhiteText(
                        extended ? message.timestamp.toLocal().toString() : timeago.format(message.timestamp),
                        color: extended ? Colors.white : Colors.grey,
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
}
