import 'package:flutter/material.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/components/roundoutline.dart';
import 'package:mania/components/strokystring.dart';
import 'package:mania/components/whitebutton.dart';
import 'package:mania/components/whiteinput.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/strings.dart';
import 'package:mania/theme/style.dart';

class Login2Screen extends StatefulWidget {
  Login2Screen({Key key}) : super(key: key);

  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  String login;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Background(
        hasBar: false,
        child: Container(
          margin: const EdgeInsets.all(Dimens.sideMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: Dimens.sideMargin, left: Dimens.sideMargin),
                height: 100,
                width: 100,
                child: Logo(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(Dimens.sideMargin),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 300,
                            margin: const EdgeInsets.only(top: 48.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  Strings.textSignIn.toUpperCase(),
                                  style: title(color: Colors.white, bold: FontWeight.w200),
                                ),
                                WhiteInput(
                                  value: login,
                                  placeholder: Strings.textLogin,
                                ),
                                WhiteInput(
                                  value: password,
                                  placeholder: Strings.textPassword,
                                  isPassword: true,
                                ),
                                WhiteText(Strings.textForgotPassword, bold: true),
                                WhiteButton(
                                  Strings.textLogin,
                                  onPressed: onLoginPressed,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                StrokyString(Strings.textOr.toUpperCase()),
                                Container(
                                  width: 200.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      RoundOutline(
                                        height: Dimens.logoSize,
                                        width: Dimens.logoSize,
                                        child: RoundedImage(
                                          'assets/images/facebook.png',
                                          onPressed: onFacebookPressed,
                                        ),
                                      ),
                                      RoundOutline(
                                        height: Dimens.logoSize,
                                        width: Dimens.logoSize,
                                        child: RoundedImage(
                                          'assets/images/google.png',
                                          onPressed: onGooglePressed,
                                        ),
                                      ),
                                      RoundOutline(
                                        height: Dimens.logoSize,
                                        width: Dimens.logoSize,
                                        padding: const EdgeInsets.all(10.0),
                                        child: NormalImage(
                                          'assets/images/twitch.png',
                                          onPressed: onTwitchPressed,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    WhiteText(Strings.textDontHaveAccount + " "),
                                    InkWell(
                                      onTap: onSignUpPressed,
                                      child: WhiteText(Strings.textSignUp, bolder: true),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onLoginPressed() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  onFacebookPressed() {
    print('Facebook');
  }

  onGooglePressed() {
    print('Google');
  }

  onTwitchPressed() {
    print('Google');
  }

  onSignUpPressed() {
    print('Sign up');
  }
}
