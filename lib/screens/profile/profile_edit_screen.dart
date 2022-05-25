import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mania/api/rest_client.dart';
import 'package:mania/app/registry.dart';
import 'package:mania/components/image.dart';
import 'package:mania/components/mania_bar.dart';
import 'package:mania/components/mania_button.dart';
import 'package:mania/components/mania_text.dart';
import 'package:mania/components/material_hero.dart';
import 'package:mania/components/transparent_input.dart';
import 'package:mania/custom/base_stateful_widget.dart';
import 'package:mania/models/api_user.dart';
import 'package:mania/resources/dimensions.dart';
import 'package:mania/resources/hero_tags.dart';

class ProfileEditScreen extends BaseStatefulWidget {
  const ProfileEditScreen(this.user, {Key? key}) : super(key: key);

  final ApiUser user;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends BaseState<ProfileEditScreen> {
  final TextEditingController _bioController = TextEditingController();
  File? avatarFile;

  @override
  void initState() {
    super.initState();

    _bioController.text = widget.user.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: ManiaBar(
        title: trans(context)?.screen_editProfile_title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.marginDouble),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  MaterialHero(
                    tag: '${HeroTags.profileAvatar}${Registry.apiUser?.id}',
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
                  const SizedBox(width: Dimens.margin),
                  Expanded(
                    child: MaterialHero(
                      tag: '${HeroTags.profilePseudo}${Registry.apiUser?.id}',
                      child: ManiaText(
                        Registry.apiUser?.pseudo,
                        boldest: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.marginDouble),
              MaterialHero(
                tag: '${HeroTags.profileDescription}${Registry.apiUser?.id}',
                child: TransparentInput(
                  controller: _bioController,
                  placeholder: trans(context)?.placeholder_writeADescription,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: Dimens.marginDouble),
              ManiaButton(
                trans(context)?.text_save,
                onPressed: onSavePressed,
              ),
              const SizedBox(height: Dimens.margin),
            ],
          ),
        ),
      ),
    );
  }

  void onAvatarPressed() {
    // pickImage();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTmp = File(image.path);
      setState(() {
        avatarFile = imageTmp;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image: $e");
      }
    }
  }

  void onSavePressed() {
    if (Registry.apiUser != null) {
      final String newBio = _bioController.value.text;
      final File? newAvatar = avatarFile;

      RestClient.service.editProfile(Registry.apiUser!.id, bio: newBio, avatar: newAvatar).then((value) {
        if (value.success) {
          Navigator.pop(context);
        }
      });
    }
  }
}
