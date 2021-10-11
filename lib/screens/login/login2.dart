import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/bloc.dart';
import 'package:mania/components/greyinput.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/theme/style.dart';

class Login2Screen extends StatefulWidget {
  Login2Screen({Key? key}) : super(key: key);

  @override
  _Login2ScreenState createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  String login = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          margin: const EdgeInsets.all(Dimens.sideMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 82.0),
                child: Logo(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(Dimens.sideMargin),
                  child: Bloc(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Sign in',
                              style: title(),
                            ),
                            Container(
                              width: 300.0,
                              child: GreyInput(
                                value: login,
                                placeholder: 'Login',
                              ),
                            ),
                            Container(
                              width: 300.0,
                              child: GreyInput(
                                value: password,
                                placeholder: 'Password',
                                isPassword: true,
                              ),
                            ),
                            Text(
                              'Forgot password ?',
                              style: text(bold: FontWeight.w500),
                            ),
                            RaisedButton(
                              onPressed: onLoginPressed,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              'Or login with',
                              style: text(),
                            ),
                            Container(
                              width: 150.0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Material(
                                    elevation: 4.0,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    child: Ink.image(
                                      image: AssetImage('assets/images/facebook.png'),
                                      width: Dimens.logoSize,
                                      height: Dimens.logoSize,
                                      fit: BoxFit.cover,
                                      child: InkWell(
                                        onTap: onFacebookPressed,
                                      ),
                                    ),
                                  ),
                                  Material(
                                    elevation: 4.0,
                                    shape: CircleBorder(),
                                    clipBehavior: Clip.hardEdge,
                                    color: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    child: Ink.image(
                                      image: AssetImage('assets/images/google.png'),
                                      width: Dimens.logoSize,
                                      height: Dimens.logoSize,
                                      fit: BoxFit.cover,
                                      child: InkWell(
                                        onTap: onGooglePressed,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Don't have an account ? ",
                                  style: text(),
                                ),
                                InkWell(
                                  onTap: onSignUpPressed,
                                  child: Text(
                                    'Sign up',
                                    style: text(bold: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

    FirebaseAuth auth = FirebaseAuth.instance;
  }

  onSignUpPressed() {
    print('Sign up');
  }

// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(StringProperty('password', password));
// }
}
