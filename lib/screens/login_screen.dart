import 'package:flutter/material.dart';
import 'package:mania/api/Requests.dart';
import 'package:mania/app/Const.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/components/roundedoutline.dart';
import 'package:mania/components/whitetext.dart';
import 'package:mania/handlers/FirebaseHandler.dart';
import 'package:mania/handlers/TwitchHandler.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static loadNextScreen(BuildContext context) {
    Requests.getUserInformations(context).then((value) {
      Requests.updateUserFollowings(context).then((value) {
        nextScreen(context);
      });
    });
  }

  static nextScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (Registry.isAuth()) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String login = "";
  String password = "";

  @override
  void initState() {
    super.initState();

    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Background(
        shouldCountBar: true,
        fullscreenScrollView: true,
        scrollViewMargin: const EdgeInsets.all(Dimens.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: Dimens.margin, left: Dimens.margin),
              height: 100,
              width: 100,
              child: Logo(),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(Dimens.margin),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          WhiteText(
                            trans(context)!.screen_login_title,
                            bolder: true,
                            fontSize: Dimens.titleSize,
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            children: [
                              WhiteText(
                                trans(context)!.screen_login_loginWithTwitchAccount,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              RoundedOutline(
                                onPressed: onTwitchPressed,
                                height: Dimens.logoSize,
                                radius: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Se connecter avec"),
                                    SizedBox(width: 10),
                                    Container(
                                      child: NormalImage(
                                        'assets/images/twitch.png',
                                        height: Dimens.logoSize - 20,
                                        width: Dimens.logoSize - 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              WhiteText(
                                trans(context)!.screen_login_ifYouDontHaveTwitchAccount,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              WhiteText(
                                trans(context)!.text_createAnAccount,
                                onPressed: () async {
                                  String url = Const.twitchUrl;
                                  await launch(url);
                                  // if (await canLaunch(url))
                                  //   await launch(url);
                                  // else
                                  //   throw "Could not launch $url";
                                },
                                textAlign: TextAlign.center,
                                color: Colours.link,
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
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     extendBodyBehindAppBar: true,
  //     extendBody: true,
  //     body: Background(
  //       shouldCountBar: true,
  //       fullscreenScrollView: true,
  //       scrollViewMargin: const EdgeInsets.all(Dimens.margin),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //             margin: const EdgeInsets.only(top: Dimens.margin, left: Dimens.margin),
  //             height: 100,
  //             width: 100,
  //             child: Logo(),
  //           ),
  //           Expanded(
  //             child: Container(
  //               margin: const EdgeInsets.all(Dimens.margin),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 20.0),
  //                 child: Container(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       Container(
  //                         height: 300,
  //                         margin: const EdgeInsets.only(top: 48.0),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: <Widget>[
  //                             Text(
  //                               Strings.textSignIn.toUpperCase(),
  //                               style: title(color: Colors.white, bold: FontWeight.w200),
  //                             ),
  //                             WhiteInput(
  //                               value: login,
  //                               placeholder: Strings.textLogin,
  //                             ),
  //                             WhiteInput(
  //                               value: password,
  //                               placeholder: Strings.textPassword,
  //                               isPassword: true,
  //                             ),
  //                             WhiteText(Strings.textForgotPassword, bold: true),
  //                             WhiteButton(
  //                               Strings.textLogin,
  //                               onPressed: onLoginPressed,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 150,
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: <Widget>[
  //                             StrokyString(Strings.textOr.toUpperCase()),
  //                             Container(
  //                               width: 200.0,
  //                               child: Row(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: <Widget>[
  //                                   RoundOutline(
  //                                     height: Dimens.logoSize,
  //                                     width: Dimens.logoSize,
  //                                     padding: const EdgeInsets.all(10),
  //                                     child: RoundedImage(
  //                                       'assets/images/facebook.png',
  //                                       onPressed: onFacebookPressed,
  //                                     ),
  //                                   ),
  //                                   RoundOutline(
  //                                     height: Dimens.logoSize,
  //                                     width: Dimens.logoSize,
  //                                     padding: const EdgeInsets.all(10),
  //                                     child: RoundedImage(
  //                                       'assets/images/google.png',
  //                                       onPressed: onGooglePressed,
  //                                     ),
  //                                   ),
  //                                   RoundOutline(
  //                                     height: Dimens.logoSize,
  //                                     width: Dimens.logoSize,
  //                                     padding: const EdgeInsets.all(10),
  //                                     child: NormalImage(
  //                                       'assets/images/twitch.png',
  //                                       onPressed: onTwitchPressed,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: <Widget>[
  //                                 WhiteText(Strings.textDontHaveAccount + " "),
  //                                 InkWell(
  //                                   onTap: onSignUpPressed,
  //                                   child: WhiteText(Strings.textSignUp, bolder: true),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  autoLogin() {
    if (Registry.firebaseUser != null || Registry.twitchUser != null) {
      LoginScreen.loadNextScreen(context);
    }
  }

  onLoginPressed() {
    print('E-mail');
  }

  onFacebookPressed() {
    print('Facebook');
  }

  onGooglePressed() {
    FirebaseHandler.signInWithGoogle(context: context).then((user) {
      if (user != null) {
        Registry.firebaseUser = user;

        LoginScreen.loadNextScreen(context);
      }
    });
  }

  onTwitchPressed() {
    TwitchHandler.showTwitchModal(context: context).then((twitchCode) {
      TwitchHandler.loginToTwitchWithCode(twitchCode).then((authResponse) {
        if (authResponse != null) {
          TwitchHandler.loginToTwitchWithAccessToken(authResponse.accessToken).then((value) {
            if (Registry.twitchUser != null) {
              LoginScreen.loadNextScreen(context);
            }
          });
        } else {
          // TODO Une erreur est survenue
        }
      });
    });
  }

  onSignUpPressed() {
    print('Sign up');
  }
}
