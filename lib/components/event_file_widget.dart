import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';

import '../utils/colors.dart';
import 'app_primary_widget.dart';
import 'common_file_placeholders.dart';

class AddFilesWidget extends StatelessWidget {
  final RxList<PlatformFile> fileList;
  final VoidCallback onFilePick;
  final double? horizontalPadding;
  final Function(int) onFilePathRemove;

  const AddFilesWidget({
    Key? key,
    required this.fileList,
    required this.onFilePick,
    required this.onFilePathRemove,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(locale.value.serviceImage, style: boldTextStyle(size: 16)).paddingSymmetric(horizontal: horizontalPadding ?? 16),
        12.height,
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPrimaryWidget(
                width: Get.width,
                constraints: const BoxConstraints(minHeight: 80),
                border: Border.all(color: primaryColor),
                borderRadius: defaultRadius,
                onTap: onFilePick,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_circle_outline_rounded, color: primaryColor, size: 24),
                    8.height,
                    Text(
                      locale.value.chooseImage,
                      style: boldTextStyle(color: primaryColor, size: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: horizontalPadding ?? 16),
              16.height,
              Text(locale.value.noteYouCanUpload, style: secondaryTextStyle(size: 10)),
              16.height,
              HorizontalList(
                spacing: 12,
                padding: const EdgeInsets.only(top: 8, right: 8),
                itemCount: fileList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Loader(),
                      ),
                      fileList[index].path.isImage
                          ? Image.file(
                              File(fileList[index].path.validate()),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(
                                width: 80,
                                height: 80,
                              ),
                            ).cornerRadiusWithClipRRect(defaultRadius)
                          : CommonPdfPlaceHolder(text: fileList[index].name, height: 80, width: 80),
                      Positioned(
                        right: -7,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: const Icon(Icons.close, color: Colors.white, size: 14),
                        ).onTap(() => onFilePathRemove.call(index)),
                      ),
                    ],
                  );
                },
              ).paddingBottom(16),
            ],
          ),
        ),
      ],
    );
  }
}

class FileElement {
  FileElement({
    this.id = -1,
    this.url = "",
  });

  int id;
  String url;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] is int
            ? json["id"]
            : json["id"] is String
                ? json["id"].toString().toInt(defaultValue: -1)
                : -1,
        url: json['url'] is String ? json['url'] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
