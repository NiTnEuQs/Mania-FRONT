import 'package:flutter/cupertino.dart';
import 'package:mania/resources/dimensions.dart';

class ManiaRichText extends StatelessWidget {
  const ManiaRichText(this.children, {Key? key}) : super(key: key);

  final List<TextSpan>? children;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: Dimens.textSize,
        ),
        children: children,
      ),
    );
  }
}
