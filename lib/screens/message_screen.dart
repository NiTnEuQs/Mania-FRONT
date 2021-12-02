import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/message.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';

class MessageScreen extends BaseStatefulWidget {
  MessageScreen(this.message, {Key? key}) : super(key: key);

  final ApiMessage message;

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends LifecycleState<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.appBackground,
      extendBodyBehindAppBar: true,
      appBar: ManiaBar(
        title: trans(context)!.text_message,
        leftItem: ManiaBarItem.back(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Background(
            shouldCountBar: true,
            padding: const EdgeInsets.all(Dimens.marginDouble),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimens.blocCornerRadius),
              bottomRight: Radius.circular(Dimens.blocCornerRadius),
            ),
            child: Message(
              widget.message,
              extended: true,
              displayAvatar: true,
              displayPseudo: true,
              onUserPressed: onUserPressed,
            ),
          ),
          Expanded(
            child: FutureBuilder<GenericResponse<List<ApiMessage>>>(
                future: RestClient.service.getMessageComments(widget.message.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListMessages(
                      snapshot.data?.response,
                      onMessagePressed: onMessagePressed,
                      onUserPressed: onUserPressed,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: WhiteText(trans(context)!.text_errorOccurred));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          // Expanded(child: ListComments(widget.comments, onCommentPressed: widget.onCommentPressed, onUserPressed: widget.onUserPressed)),
        ],
      ),
    );
  }

  onBackPressed() {
    Navigator.pop(context);
  }

  onMessagePressed(ApiMessage message) {
    Navigator.pushNamed(context, "/message", arguments: message);
  }

  onUserPressed(ApiUser user) {
    Navigator.pushNamed(context, "/profile", arguments: user);
  }
}
