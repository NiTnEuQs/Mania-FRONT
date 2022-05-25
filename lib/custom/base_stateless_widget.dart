import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/mixins/mixin_localizator.dart';

abstract class BaseStatelessWidget extends ConsumerWidget with Localizator {
  BaseStatelessWidget({Key? key}) : super(key: key);
}
