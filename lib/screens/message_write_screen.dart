import 'package:flutter/material.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/transparentinput.dart';
import 'package:mania/components/whitebutton.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class MessageWriteScreen extends StatefulWidget {
  const MessageWriteScreen({Key? key}) : super(key: key);

  @override
  _MessageWriteScreenState createState() => _MessageWriteScreenState();
}

class _MessageWriteScreenState extends State<MessageWriteScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ManiaBar(
        title: trans(context)!.text_publication,
        leftItem: ManiaBarItem.back(context),
      ),
      body: Background(
        shouldCountBar: true,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginDouble),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Dimens.marginDouble),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialHero(
                      tag: '${HeroTags.PROFILE_AVATAR}${Registry.apiUser?.id}',
                      child: RoundedImage(
                        Registry.apiUser?.imageUrl,
                        isUrl: true,
                        height: Dimens.profileAvatarSize,
                        width: Dimens.profileAvatarSize,
                      ),
                    ),
                    Expanded(
                      child: TransparentInput(
                        controller: _controller,
                        expands: true,
                        placeholder: trans(context)!.placeholder_writeYourMessage,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimens.marginDouble),
            WhiteButton(
              trans(context)!.text_publish,
              onPressed: onPublishPressed,
            ),
          ],
        ),
      ),
    );
  }

  onPublishPressed() {
    if (Registry.apiUser != null) {
      RestClient.service.publishMessage(Registry.apiUser!.id, _controller.text).then((value) {
        if (value.success) {
          Navigator.pop(context);
        }
      });
    }
  }
}
