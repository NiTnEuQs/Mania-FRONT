import 'package:flutter/material.dart';
import 'package:mania/resources/dimensions.dart';

class NormalImage extends StatelessWidget {
  NormalImage(this._image, {Key? key, this.circle, this.width, this.height, this.onPressed});

  final String _image;
  final bool? circle;
  final double? width, height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: circle ?? false ? CircleBorder() : RoundedRectangleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Ink.image(
        image: AssetImage(_image),
        width: width ?? Dimens.logoSize,
        height: height ?? Dimens.logoSize,
        fit: BoxFit.cover,
        child: InkWell(
          onTap: onPressed,
        ),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  RoundedImage(this._image, {Key? key, this.width, this.height, this.onPressed});

  final String _image;
  final double? width, height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return NormalImage(
      _image,
      circle: true,
      width: width ?? Dimens.logoSize,
      height: height ?? Dimens.logoSize,
      onPressed: onPressed,
    );
  }
}
