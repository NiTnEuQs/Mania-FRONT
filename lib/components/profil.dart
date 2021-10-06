import 'package:flutter/material.dart';
import 'package:mania/components/botprofil.dart';
import 'package:mania/components/topprofil.dart';

class Profil extends StatelessWidget {
  // Profil({Key key, this.user});

  // final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopProfil(),
        Expanded(child: BottomProfil()),
        // TopProfil(hasBar:true, user.profil),
        // Expanded(child: BottomProfil(user.message)),
      ],
    );
  }
}
