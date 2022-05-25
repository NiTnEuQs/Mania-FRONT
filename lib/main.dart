import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/system.dart';
import 'package:mania/custom/base_stateless_widget.dart';
import 'package:mania/providers/theme_mode_provider.dart';
import 'package:mania/routes.dart';
import 'package:mania/theme/theme.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends BaseStatelessWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    System.initialize(context);
    System.transparentStatusBar();
    System.portraitOnly(upsideDown: true);

    return ProviderScope(
      child: MaterialApp(
        title: trans(context)?.app_name ?? "",
        theme: appLightTheme(),
        darkTheme: appDarkTheme(),
        themeMode: themeMode,
        initialRoute: '/',
        onGenerateRoute: routes,
        navigatorObservers: [routeObserver],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        // localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        //   return locale;
        // },
      ),
    );
  }
}
