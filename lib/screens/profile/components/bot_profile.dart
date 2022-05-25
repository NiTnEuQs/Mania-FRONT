import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/conditional_widget.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/providers/user_provider.dart';

class BotProfile extends BaseStatefulWidget {
  const BotProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final int userId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BotProfileState();
}

class _BotProfileState extends LifecycleState<BotProfile> {
  late ApiUser _user;
  late List<ApiMessage> _messages;

  @override
  void onResume() {
    super.onResume();

    ref.read(userProvider).getUser(userId: widget.userId);
    ref.read(userProvider).getMessages(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(userProvider).user;
    _messages = ref.watch(userProvider).messages;

    return ConditionalWidget(
      conditions: widget.userId == _user.id,
      child: ListMessages(
        _messages,
        shrinkWrap: true,
        displayAvatar: false,
        displayPseudo: false,
      ),
    );
  }
}
