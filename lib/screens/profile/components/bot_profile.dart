import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/FutureWidget.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/GenericResponse.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/utils/StringUtils.dart';

class BotProfile extends StatefulWidget {
  BotProfile({Key? key, required this.userId});

  final int userId;

  @override
  State<BotProfile> createState() => _BotProfileState();
}

class _BotProfileState extends State<BotProfile> {
  TextEditingController _sendMessageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<GenericResponse<List<ApiMessage>>>(
        future: RestClient.service.getUserMessages(widget.userId),
        builder: (context, snapshot) {
          return FutureWidget(
            snapshot,
            errorColor: Colours.primaryColor,
            circleColor: Colours.primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListMessages(
                    snapshot.data?.response,
                    noDataColor: Colors.black,
                    displayAvatar: false,
                    displayPseudo: false,
                    displayWriteAMessage: widget.userId == Registry.apiUser?.id,
                    openExtendedWriter: true,
                    sendMessageController: _sendMessageController,
                    onSendMessagePressed: (message) {
                      if (!isStringEmpty(message)) {
                        RestClient.service.publishMessage(Registry.apiUser!.id, message!).then((value) {
                          if (value.success) {
                            _sendMessageController.clear();
                            setState(() {});
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
