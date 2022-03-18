import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/components/ConditionalWidget.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/ApiMessage.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/providers/UserLoggedProvider.dart';
import 'package:mania/providers/UserProvider.dart';
import 'package:mania/utils/StringUtils.dart';

class BotProfile extends BaseStatefulWidget {
  BotProfile({Key? key, required this.userId});

  final int userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BotProfileState();
}

class _BotProfileState extends LifecycleState<BotProfile> {
  late ApiUser _loggedUser;
  late ApiUser _user;
  late List<ApiMessage> _messages;

  TextEditingController _sendMessageController = new TextEditingController();

  @override
  void onResume() {
    super.onResume();

    ref.read(userProvider).getUser(userId: widget.userId);
    ref.read(userProvider).getMessages(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    _loggedUser = ref.watch(userLoggedProvider).user;
    _user = ref.watch(userProvider).user;
    _messages = ref.watch(userProvider).messages;

    return Expanded(
      child: ConditionalWidget(
        conditions: widget.userId == _user.id,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListMessages(
                _messages,
                noDataColor: Colors.black,
                displayAvatar: false,
                displayPseudo: false,
                displayWriteAMessage: widget.userId == _loggedUser.id,
                openExtendedWriter: true,
                sendMessageController: _sendMessageController,
                onSendMessagePressed: onSendMessagePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSendMessagePressed(message) {
    if (!isStringEmpty(message)) {
      RestClient.service.publishMessage(Registry.apiUser!.id, message!).then((value) {
        if (value.success) {
          _sendMessageController.clear();

          ref.read(userProvider).getMessages(userId: widget.userId);
        }
      });
    }
  }
}
