import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/writer.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/user_logged_provider.dart';
import 'package:mania/providers/user_provider.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/screens/profile/components/bot_profile.dart';
import 'package:mania/screens/profile/components/top_profile.dart';
import 'package:mania/utils/string_utils.dart';

class ProfileScreen extends BaseStatefulWidget {
  const ProfileScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends LifecycleState<ProfileScreen> {
  _ProfileScreenState();

  late final ApiUser _user;

  late ApiUser _loggedUser;

  final TextEditingController _sendMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    _loggedUser = ref.watch(userLoggedProvider).user;

    return Scaffold(
      appBar: ManiaBar(
        title: trans(context)?.screen_profile_title(_user.pseudo),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopProfile(userId: _user.id),
                  BotProfile(userId: _user.id),
                ],
              ),
            ),
          ),
          if (_user.id == _loggedUser.id)
            Padding(
              padding: const EdgeInsets.all(Dimens.margin),
              child: Writer(
                controller: _sendMessageController,
                openExtendedWriter: true,
                onSendMessagePressed: onSendMessagePressed,
              ),
            ),
        ],
      ),
    );
  }

  void onSendMessagePressed(String? message) {
    if (!isStringEmpty(message)) {
      RestClient.service.publishMessage(Registry.apiUser!.id, message!).then((value) {
        if (value.success) {
          _sendMessageController.clear();

          ref.read(userProvider).getMessages(userId: _user.id);
        }
      });
    }
  }

  void onWriteMessagePressed() {
    Navigator.pushNamed(context, "/message/write");
  }
}
