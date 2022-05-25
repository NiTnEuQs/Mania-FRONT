import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shouldUpdateProvider = ChangeNotifierProvider<ShouldUpdateNotifier>((ref) => ShouldUpdateNotifier(ref));

class ShouldUpdateNotifier extends ChangeNotifier {
  ShouldUpdateNotifier(this.ref);

  Ref ref;
  bool mainMenuScreen = false;

  void updateMainMenuScreen({bool shouldUpdate = true}) {
    mainMenuScreen = shouldUpdate;
    notifyListeners();
  }
}
