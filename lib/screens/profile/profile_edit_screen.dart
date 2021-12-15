import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mania/api/RestClient.dart';
import 'package:mania/app/Registry.dart';
import 'package:mania/app/Utils.dart';
import 'package:mania/components/background.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/transparentinput.dart';
import 'package:mania/components/whitebutton.dart';
import 'package:mania/models/ApiUser.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/herotags.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _bioController = TextEditingController();
  File? avatarFile;

  @override
  void initState() {
    super.initState();

    _bioController.text = widget.user.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ManiaBar(
        title: trans(context)!.screen_editProfile_title,
        leftItem: ManiaBarItem.back(context),
      ),
      body: Background(
        padding: const EdgeInsets.all(Dimens.marginDouble),
        shouldCountBar: true,
        child: Column(
          children: [
            Row(
              children: [
                MaterialHero(
                  tag: '${HeroTags.PROFILE_AVATAR}${Registry.apiUser?.id}',
                  child: avatarFile != null
                      ? InkWell(
                          onTap: onAvatarPressed,
                          child: ClipOval(
                            child: Image.file(
                              avatarFile!,
                              fit: BoxFit.cover,
                              height: Dimens.profileAvatarSize,
                              width: Dimens.profileAvatarSize,
                            ),
                          ),
                        )
                      : RoundedImage(
                          Registry.apiUser?.imageUrl,
                          isUrl: avatarFile == null,
                          height: Dimens.profileAvatarSize,
                          width: Dimens.profileAvatarSize,
                          onPressed: onAvatarPressed,
                        ),
                ),
              ],
            ),
            SizedBox(height: Dimens.marginDouble),
            TransparentInput(
              controller: _bioController,
              // expands: true,
              placeholder: trans(context)!.placeholder_writeADescription,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: Dimens.marginDouble),
            WhiteButton(
              trans(context)!.text_save,
              onPressed: onSavePressed,
            ),
          ],
        ),
      ),
    );
  }

  onAvatarPressed() {
    // pickImage();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTmp = File(image.path);
      setState(() {
        this.avatarFile = imageTmp;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  onSavePressed() {
    if (Registry.apiUser != null) {
      String newBio = _bioController.value.text;
      File? newAvatar = this.avatarFile;

      RestClient.service.editProfile(Registry.apiUser!.id, bio: newBio, avatar: newAvatar).then((value) {
        if (value.success) {
          Navigator.pop(context);
        }
      });
    }
  }
}
