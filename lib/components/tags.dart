import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags(this.tags, {this.textColor, this.backgroundColor});

  final List<String> tags;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          final String tag = tags[index];

          return Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Center(
              child: Text(
                tag,
                style: TextStyle(color: textColor ?? const Color(0xFF333333)),
              ),
            ),
          );
        },
      ),
    );
  }
}
