import 'package:flutter/material.dart';
import 'package:mania/main.dart';
import 'package:mania/mixins/MixinLocalizator.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseState<T extends StatefulWidget> extends State<T> with Localizator {}

abstract class LifecycleState<T extends StatefulWidget> extends BaseState<T> with RouteAware {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   onStart();
  //   onResume();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    onStart();
    onResume();
  }

  @override
  void didPopNext() {
    onResume();
  }

  void onStart() {}

  void onResume() {}

  void onInactive() {}

  void onPause() {}

  void onDetach() {}
}
