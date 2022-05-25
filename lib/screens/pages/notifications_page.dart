import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/expanded_scroll_view.dart';
import 'package:mania/components/list_messages.dart';
import 'package:mania/components/load_more_scroll_view.dart';
import 'package:mania/components/mania_refresh_indicator.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/rounded_button.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/delegates/users_search_delegate.dart';
import 'package:mania/models/api_message.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/models/paginator.dart';
import 'package:mania/providers/arguments/args_recent_notifications.dart';
import 'package:mania/providers/user_followings_provider.dart';
import 'package:mania/providers/user_logged_provider.dart';
import 'package:mania/resources/dimensions.dart';

class NotificationsPage extends BaseStatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends BaseState<NotificationsPage> {
  late ApiUser _user;

  void onSearchPressed() {
    showSearch(
      context: context,
      delegate: UsersSearchDelegate(),
    );
  }

  void _loadMore(Paginator<ApiMessage>? paginator) {
    if (paginator == null || !paginator.hasNextPage) return;

    ref.refresh(userRecentNotificationsProvider(ArgsRecentNotifications(_user.id, paginator.nextPage)));
  }

  @override
  Widget build(BuildContext context) {
    _user = ref.watch(userLoggedProvider).user;

    return ManiaRefreshIndicator(
      onRefresh: () => ref.refresh(userRecentNotificationsProvider(ArgsRecentNotifications(_user.id, 1))),
      child: ref.watch(userRecentNotificationsProvider(ArgsRecentNotifications(_user.id))).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => ExpandedScrollView(
              child: Center(
                child: ManiaText(trans(context)?.text_errorOccurred),
              ),
            ),
            data: (data) {
              if (data.response?.data?.length == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final int nbResponses = data.response!.data!.length;

              return nbResponses <= 0
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.marginDouble * 2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ManiaText(
                              trans(context)?.screen_mainMenu_zeroNotification,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: Dimens.marginDouble),
                            RoundedContainer(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.marginDouble,
                                vertical: Dimens.margin,
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: onSearchPressed,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Theme.of(context).textTheme.bodyText2?.color,
                                  ),
                                  const SizedBox(width: Dimens.margin),
                                  ManiaText(trans(context)?.text_search),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : LoadMoreScrollView(
                      onLoadMore: () {
                        _loadMore(data.response);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (nbResponses >= 10)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: Dimens.margin,
                                right: Dimens.margin,
                                top: Dimens.marginDouble,
                                bottom: Dimens.margin,
                              ),
                              child: ManiaText(
                                trans(context)?.text_onlyTenLastNotificationsAreDisplayed,
                                textAlign: TextAlign.center,
                                fontDimension: TextDimension.xs,
                              ),
                            ),
                          ListMessages(
                            data.response?.data,
                            shrinkWrap: true,
                            displayAvatar: true,
                            displayPseudo: true,
                          ),
                        ],
                      ),
                    );
            },
          ),
    );
  }
}
