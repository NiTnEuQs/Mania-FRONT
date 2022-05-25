import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mania/app/const.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/logo.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/rounded_button.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/handlers/firebase_handler.dart';
import 'package:mania/handlers/twitch_handler.dart';
import 'package:mania/resources/colours.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends BaseStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static void nextScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (Registry.isAuth()) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
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
              child: const Logo(),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(Dimens.margin),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ManiaText(
                            trans(context)?.screen_login_title,
                            bolder: true,
                            fontSize: Dimens.titleSize,
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            children: [
                              ManiaText(
                                trans(context)?.screen_login_loginWithTwitchAccount,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              RoundedContainer.size(
                                onPressed: onTwitchPressed,
                                size: Dimens.logoSize,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text("Se connecter avec"),
                                    SizedBox(width: 10),
                                    NormalImage(
                                      'assets/images/twitch.png',
                                      height: Dimens.logoSize - 20,
                                      width: Dimens.logoSize - 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ManiaText(
                                trans(context)?.screen_login_ifYouDontHaveTwitchAccount,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              ManiaText(
                                trans(context)?.text_createAnAccount,
                                onPressed: () async {
                                  const String url = Const.twitchUrl;
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

  void autoLogin() {
    if (Registry.firebaseUser != null || Registry.twitchUser != null) {
      LoginScreen.nextScreen(context);
    }
  }

  void onLoginPressed() {}

  void onFacebookPressed() {}

  void onGooglePressed() {
    FirebaseHandler.signInWithGoogle(context: context, mounted: mounted).then((user) {
      if (user != null) {
        Registry.firebaseUser = user;

        LoginScreen.nextScreen(context);
      }
    });
  }

  void onTwitchPressed() {
    TwitchHandler.showTwitchModal(context: context).then((twitchCode) {
      TwitchHandler.loginToTwitchWithCode(twitchCode).then((authResponse) {
        if (authResponse != null) {
          TwitchHandler.loginToTwitchWithAccessToken(authResponse.accessToken).then((value) {
            if (Registry.twitchUser != null) {
              LoginScreen.nextScreen(context);
            }
          });
        } else {
          // TODO Une erreur est survenue
        }
      });
    });
  }

  void onSignUpPressed() {}
}
