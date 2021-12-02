import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/GenericResponse.dart';

class BotProfile extends StatefulWidget {
  BotProfile({Key? key, required this.userId, this.onMessagePressed});

  final int userId;
  final Function(ApiMessage)? onMessagePressed;

  @override
  State<BotProfile> createState() => _BotProfileState();
}

class _BotProfileState extends State<BotProfile> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<GenericResponse<List<ApiMessage>>>(
        future: RestClient.service.getUserMessages(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListMessages(
              snapshot.data!.response,
              displayAvatar: false,
              displayPseudo: false,
              onMessagePressed: widget.onMessagePressed,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: WhiteText(
                trans(context)!.text_errorOccurred,
                color: Colors.black,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
