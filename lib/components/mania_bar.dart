import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/extensions/bightness_extension.dart';
import 'package:mania/providers/theme_brightness_provider.dart';
import 'package:mania/resources/dimensions.dart';

class ManiaBar extends BaseStatelessWidget implements PreferredSizeWidget {
  ManiaBar({
    this.title,
    this.titleIcon,
    this.leading,
    this.noLeading = false,
    this.actions,
  });

  final String? title;
  final Widget? titleIcon;
  final Widget? leading;
  final bool noLeading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.appbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness themeBrightness = ref.watch(themeBrightnessProvider);

    return AppBar(
      systemOverlayStyle: themeBrightness.isDark()
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titleIcon != null) titleIcon!,
          if (title?.isNotEmpty ?? false)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ManiaText(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.primary,
                boldest: true,
              ),
            ),
        ],
      ),
      leading: noLeading
          ? null
          : (leading ??
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  );
                },
              )),
      actions: actions,
    );
  }
}
