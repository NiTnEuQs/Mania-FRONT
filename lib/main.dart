import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/System.dart';
import 'package:mania/resources/strings.dart';
import 'package:mania/routes.dart';
import 'package:mania/theme/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    System.initialize(context);
    System.transparentStatusBar();
    System.portraitOnly(upsideDown: true);

    return ProviderScope(
      child: MaterialApp(
        title: Strings.appName,
        theme: appTheme(),
        initialRoute: '/',
        onGenerateRoute: routes,
        navigatorObservers: [routeObserver],
        localizationsDelegates: [
          RefreshLocalizations.delegate,
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
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
