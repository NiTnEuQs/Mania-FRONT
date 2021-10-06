import 'package:flutter/material.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/tags.dart';
import 'package:mania/components/whitebutton.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/dimensions.dart';

class TopProfil extends StatelessWidget {
  TopProfil({Key key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.topProfilHeight,
      padding: EdgeInsets.only(
        top: Dimens.appbarHeight + Dimens.appbarMargin + Dimens.topProfilSideMargin,
        bottom: Dimens.topProfilSideMargin,
        left: Dimens.topProfilSideMargin,
        right: Dimens.topProfilSideMargin,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RoundOutline(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(0),
            child: RoundedImage(
              'assets/images/facebook.png',
            ),
          ),
          WhiteText(
            '@${'pseudo0'}',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  WhiteText(
                    '194k',
                    bolder: true,
                  ),
                  WhiteText(' followers'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  WhiteButton(
                    'Follow',
                    onPressed: () {},
                  ),
                  // WhiteButton(
                  //   'X',
                  // ),
                  // WhiteButton(
                  //   'V'
                  // ),
                ],
              )
            ],
          ),
          WhiteText(
            'Bonsoir les fleurs, je suis Ponce, alias Poncefleur.'
            ' Je suis un streamer qui adore les fleurs.'
            " N'hésitez pas à follow",
            textAlign: TextAlign.justify,
          ),
          Flexible(
            child: Tags(
              <String>['Animation', 'Games', 'Twitch', 'Simulation'],
              textColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
