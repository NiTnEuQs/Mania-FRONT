import 'package:flutter/material.dart';
import 'package:mania/components/bloc.dart';
import 'package:mania/resources/dimensions.dart';

class BottomProfil extends StatelessWidget {
  BottomProfil({Key key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            child: Bloc(
              shadow: true,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.chat_bubble_outline),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$index Salut, aujourd'hui j'ai fait un poulet braisé, je l'ai trop dégusté, c'était trop bon :D\nDemain c'est resto chinois avec des potes hihi",
                        ),
                        SizedBox(
                          height: Dimens.margin,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('3 comments'),
                            Text('40 views'),
                            Text(
                              '2min ago',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
