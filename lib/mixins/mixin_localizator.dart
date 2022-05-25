import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin Localizator {
  AppLocalizations? trans(BuildContext context) => AppLocalizations.of(context);
}
