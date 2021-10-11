import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  Tags(this.tags, {Key? key, this.textColor, this.backgroundColor});

  final List<String> tags;
  final Color? textColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          String tag = tags[index];

          return Container(
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Center(
              child: Text(
                tag,
                style: TextStyle(color: textColor ?? Color(0xFF333333)),
              ),
            ),
          );
        },
      ),
    );
  }
}
