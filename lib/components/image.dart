import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class NormalImage extends StatelessWidget {
  NormalImage(this._image, {Key? key, this.isUrl = false, this.circle, this.width, this.height, this.fit, this.onPressed});

  final String? _image;
  final bool isUrl;
  final bool? circle;
  final double? width, height;
  final BoxFit? fit;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: circle ?? false ? CircleBorder() : RoundedRectangleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      // child: isUrl ? Image.network(_image) : Image.asset(_image),
      child: Ink.image(
        image: isUrl ? Image.network(_image ?? "").image : Image.asset(_image ?? "").image,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        child: InkWell(
          onTap: onPressed,
        ),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  RoundedImage(this._image, {Key? key, this.isUrl = false, this.width, this.height, this.fit, this.onPressed});

  final String? _image;
  final bool isUrl;
  final double? width, height;
  final BoxFit? fit;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalImage(
      _image,
      isUrl: isUrl,
      circle: true,
      width: width ?? Dimens.logoSize,
      height: height ?? Dimens.logoSize,
      onPressed: onPressed,
      fit: fit,
    );
  }
}
