import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/common_base.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String firstName;
  final String lastName;
  final Color? color;
  final String? placeHolderImage;
  final AlignmentGeometry? alignment;
  final bool usePlaceholderIfUrlEmpty;
  final bool circle;
  final double? radius;
  final int bottomLeftRadius;
  final int bottomRightRadius;
  final int topLeftRadius;
  final int topRightRadius;

  const CachedImageWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.firstName = "",
    this.lastName = "",
    this.color,
    this.placeHolderImage,
    this.alignment,
    this.radius,
    this.usePlaceholderIfUrlEmpty = true,
    this.circle = false,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (url.validate().isEmpty) {
      return Container(
        height: height,
        width: width,
        color: color ?? grey.withOpacity(0.1),
        alignment: alignment,
        //padding: EdgeInsets.all(10),
        //child: Image.asset(ic_no_photo, color: appStore.isDarkMode ? Colors.white : Colors.black),
        child: PlaceHolderWidget(
          height: height,
          width: width,
          alignment: alignment ?? Alignment.center,
          child: circle
              ? Text(
                  "${firstName.firstLetter.toUpperCase()}${lastName.firstLetter.toUpperCase()}",
                  style: primaryTextStyle(size: (height.validate() * 0.3).toInt(), decoration: TextDecoration.none),
                )
              : null,
        ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0)),
      ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
    } else if (url.validate().startsWith('http')) {
      return CachedNetworkImage(
        placeholder: (_, __) {
          return PlaceHolderWidget(
            height: height,
            width: width,
            alignment: alignment ?? Alignment.center,
            child: circle
                ? Text(
                    "${firstName.firstLetter.toUpperCase()}${lastName.firstLetter.toUpperCase()}",
                    style: primaryTextStyle(size: (height.validate() * 0.3).toInt(), decoration: TextDecoration.none),
                  )
                : null,
          ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0)).visible(usePlaceholderIfUrlEmpty);
        },
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        color: color,
        alignment: alignment as Alignment? ?? Alignment.center,
        errorWidget: (_, s, d) {
          return PlaceHolderWidget(
            height: height,
            width: width,
            alignment: alignment ?? Alignment.center,
            child: circle
                ? Text(
                    "${firstName.firstLetter.toUpperCase()}${lastName.firstLetter.toUpperCase()}",
                    style: primaryTextStyle(size: (height.validate() * 0.3).toInt(), decoration: TextDecoration.none),
                  )
                : null,
          ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
        },
      ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
    } else {
      if (url.startsWith(r"assets/")) {
        return Image.asset(
          url,
          height: height,
          width: width,
          fit: fit,
          color: color,
          alignment: alignment ?? Alignment.center,
          errorBuilder: (_, s, d) {
            return PlaceHolderWidget(
              height: height,
              width: width,
              alignment: alignment ?? Alignment.center,
              child: circle
                  ? Text(
                      "${firstName.firstLetter.toUpperCase()}${lastName.firstLetter.toUpperCase()}",
                      style: primaryTextStyle(size: (height.validate() * 0.3).toInt(), decoration: TextDecoration.none),
                    )
                  : null,
            ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
          },
        ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
      } else {
        return Image.file(
          File(url),
          height: height,
          width: width,
          fit: fit,
          color: color,
          alignment: alignment ?? Alignment.center,
          errorBuilder: (_, s, d) {
            return PlaceHolderWidget(
              height: height,
              width: width,
              alignment: alignment ?? Alignment.center,
              child: circle
                  ? Text(
                      "${firstName.firstLetter.toUpperCase()}${lastName.firstLetter.toUpperCase()}",
                      style: primaryTextStyle(size: (height.validate() * 0.3).toInt(), decoration: TextDecoration.none),
                    )
                  : null,
            ).cornerRadiusWithClipRRectOnly(topLeft: topLeftRadius,topRight: topRightRadius,bottomLeft: bottomLeftRadius,bottomRight: bottomRightRadius).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
          },
        ).cornerRadiusWithClipRRect(radius ?? (circle ? (height.validate() / 2) : 0));
      }
    }
  }
}
