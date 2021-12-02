import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mania/app/Utils.dart' as utils;

mixin Localizator {
  AppLocalizations? trans(BuildContext context) {
    return utils.trans(context);
  }
}
