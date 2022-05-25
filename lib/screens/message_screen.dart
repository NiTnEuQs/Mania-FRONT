import 'package:flutter/material.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/message.dart';
import 'package:mania/components/writer.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/generic_response.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/utils/string_utils.dart';

class MessageScreen extends BaseStatefulWidget {
  const MessageScreen(this.message, {Key? key}) : super(key: key);

  final ApiMessage message;

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends LifecycleState<MessageScreen> {
  final TextEditingController _sendMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ManiaBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  topMessage(),
                  botMessage(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.margin),
            child: Writer(
              parentMessageId: widget.message.id,
              controller: _sendMessageController,
              onSendMessagePressed: (message) {
                if (!isStringEmpty(message)) {
                  RestClient.service.publishMessage(Registry.apiUser!.id, message!, parentMessageId: widget.message.id).then((value) {
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
  }

  Widget topMessage() {
    return Padding(
      padding: const EdgeInsets.all(Dimens.marginDouble),
      child: Message(
        widget.message,
        extended: true,
        displayAvatar: true,
        displayPseudo: true,
      ),
    );
  }

  Widget botMessage() {
    return FutureBuilder<GenericResponse<List<ApiMessage>>>(
      future: RestClient.service.getMessageComments(widget.message.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ListMessages(
                snapshot.data?.response,
                shrinkWrap: true,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: ManiaText(trans(context)?.text_errorOccurred));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
