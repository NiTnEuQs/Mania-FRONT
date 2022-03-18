import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/mixins/MixinLocalizator.dart';

abstract class BaseStatelessWidget extends ConsumerWidget with Localizator {}
