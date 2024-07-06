import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_primary_widget.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/cached_image_widget.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import 'add_logistic_controller.dart';

class AddLogisticScreen extends StatefulWidget {
  final bool isEdit;

  const AddLogisticScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<AddLogisticScreen> createState() => _AddLogisticScreenState();
}

class _AddLogisticScreenState extends State<AddLogisticScreen> {
  final AddLogisticController addLogisticController = Get.put(AddLogisticController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: widget.isEdit ? locale.value.updateLogistic : locale.value.addLogistic,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => addLogisticController.imageFile.value.path.isNotEmpty || addLogisticController.logisticImage.value.isNotEmpty
                      ? Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: Loader(),
                              ).visible(addLogisticController.logisticImage.value.isNotEmpty || addLogisticController.imageFile.value.path.isNotEmpty),
                              DottedBorderWidget(
                                radius: defaultRadius,
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                gap: 1.5,
                                child: CachedImageWidget(
                                  url: addLogisticController.imageFile.value.path.isNotEmpty ? addLogisticController.imageFile.value.path : addLogisticController.logisticImage.value,
                                  height: 110,
                                  width: 110,
                                  fit: BoxFit.cover,
                                ).cornerRadiusWithClipRRect(defaultRadius),
                              ),
                              Positioned(
                                top: 110 * 3 / 4 + 6,
                                left: 110 * 3 / 4 + 6,
                                child: GestureDetector(
                                  onTap: () {
                                    hideKeyboard(context);
                                    addLogisticController.showBottomSheet(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: boxDecorationDefault(shape: BoxShape.circle, color: Colors.white),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor),
                                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).paddingBottom(16),
                        )
                      : Column(
                          children: [
                            AppPrimaryWidget(
                              width: Get.width,
                              constraints: const BoxConstraints(minHeight: 80),
                              border: Border.all(color: primaryColor),
                              borderRadius: defaultRadius,
                              onTap: () {
                                hideKeyboard(context);
                                addLogisticController.showBottomSheet(context);
                              },
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
                            ),
                            16.height,
                            Text(locale.value.noteYouCanUploadImageWithJpgPngJpegExtensions, style: secondaryTextStyle(size: 10)),
                          ],
                        ),
                ),
                16.height,
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        title: locale.value.logisticName,
                        controller: addLogisticController.nameCont,
                        textFieldType: TextFieldType.NAME,
                        decoration: inputDecoration(
                          context,
                          hintText: locale.value.enterTheLogisticName,
                          fillColor: context.cardColor,
                          filled: true,
                        ),
                      ),
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(locale.value.status, style: primaryTextStyle()).expand(),
                          Obx(
                            () => Switch.adaptive(
                              value: addLogisticController.isStatus.value,
                              activeColor: context.primaryColor,
                              inactiveTrackColor: context.primaryColor.withOpacity(0.2),
                              inactiveThumbColor: context.primaryColor.withOpacity(0.5),
                              onChanged: (val) {
                                addLogisticController.isStatus = val.obs;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      16.height,
                      AppButton(
                        text: locale.value.save,
                        width: Get.width,
                        textStyle: appButtonTextStyleWhite,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (addLogisticController.imageFile.value.path.isNotEmpty || addLogisticController.logisticImage.isNotEmpty) {
                              hideKeyBoardWithoutContext();
                              addLogisticController.addUpdateLogistics();
                            } else {
                              toast(locale.value.selectTheLogisticImage);
                            }
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(() => const LoaderWidget().visible(addLogisticController.isLoading.value)),
        ],
      ),
    );
  }
}
