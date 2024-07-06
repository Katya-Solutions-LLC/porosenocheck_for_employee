import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import 'cached_image_widget.dart';

class ProfilePicWidget extends StatelessWidget {
  final double picSize;
  final String profileImage;
  final String heroTag;
  final String firstName;
  final String lastName;
  final String userName;
  final String subInfo;
  final Function()? onCameraTap;
  final Function()? onPicTap;
  final bool showBgCurves;
  final bool showOnlyPhoto;
  final bool showCameraIconOnCornar;

  const ProfilePicWidget({
    super.key,
    this.picSize = 100,
    required this.profileImage,
    required this.heroTag,
    this.firstName = "",
    this.lastName = "",
    required this.userName,
    this.subInfo = "",
    this.onCameraTap,
    this.onPicTap,
    this.showBgCurves = true,
    this.showCameraIconOnCornar = true,
    this.showOnlyPhoto = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (showBgCurves)
          Positioned(
            right: -20,
            top: -50,
            child: Image.asset(
              Assets.petProfileProfileBgPettern,
              color: Colors.grey.shade400.withOpacity(0.3),
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
        if (showBgCurves)
          Positioned(
            left: -20,
            top: -50,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                color: Colors.grey.shade400.withOpacity(0.3),
                Assets.petProfileProfileBgPettern,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),
        Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: onPicTap,
                    child: Stack(
                      children: [
                        DottedBorderWidget(
                          color: secondaryColor,
                          dotsWidth: 10,
                          strokeWidth: 3,
                          gap: 4,
                          padding: const EdgeInsets.all(8),
                          radius: (picSize * 0.5) + 20,
                          child: Hero(
                            tag: heroTag,
                            child: CachedImageWidget(
                              url: profileImage,
                              firstName: firstName,
                              lastName: lastName,
                              height: picSize,
                              width: picSize,
                              fit: BoxFit.cover,
                              circle: true,
                            ),
                          ),
                        ).paddingOnly(top: 10),
                        Positioned(
                          top: picSize * 3 / 4 + 8,
                          left: picSize * 3 / 4 + 8,
                          child: GestureDetector(
                            onTap: onCameraTap,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: boxDecorationDefault(shape: BoxShape.circle, color: Colors.white),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ).visible(showCameraIconOnCornar)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (!showOnlyPhoto) ...[
              16.height,
              Text(userName, style: primaryTextStyle(size: 22)),
              4.height,
              Text(subInfo, style: secondaryTextStyle(size: 14)),
              8.height,
              Container(
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 14),
                child: Text(
                  loginUserData.value.userType.capitalizeFirstLetter(),
                  style: secondaryTextStyle(color: context.scaffoldBackgroundColor),
                ),
              )
            ],
          ],
        ),
      ],
    );
  }
}
