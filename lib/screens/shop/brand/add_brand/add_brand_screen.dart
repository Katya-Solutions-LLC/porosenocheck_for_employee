import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/screens/shop/brand/add_brand/add_brand_controller.dart';

import '../../../../components/app_primary_widget.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../components/loader_widget.dart';
import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';

class AddBrandScreen extends StatefulWidget {
  final bool isEdit;

  const AddBrandScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final AddBrandController addBrandController = Get.put(AddBrandController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: widget.isEdit ? locale.value.updateBrand : locale.value.addBrand,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => addBrandController.imageFile.value.path.isNotEmpty || addBrandController.brandImage.value.isNotEmpty
                      ? Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: Loader(),
                              ).visible(addBrandController.brandImage.value.isNotEmpty || addBrandController.imageFile.value.path.isNotEmpty),
                              DottedBorderWidget(
                                radius: defaultRadius,
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                gap: 1.5,
                                child: CachedImageWidget(
                                  url: addBrandController.imageFile.value.path.isNotEmpty ? addBrandController.imageFile.value.path : addBrandController.brandImage.value,
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
                                    addBrandController.showBottomSheet(context);
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
                                addBrandController.showBottomSheet(context);
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
                            Text(locale.value.noteYouCanUploadOne, style: secondaryTextStyle(size: 10)),
                          ],
                        ),
                ),
                16.height,
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        title: locale.value.brandName,
                        controller: addBrandController.nameCont,
                        textFieldType: TextFieldType.NAME,
                        decoration: inputDecoration(
                          context,
                          hintText: locale.value.enterTheBrandName,
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
                              value: addBrandController.isStatus.value,
                              activeColor: context.primaryColor,
                              inactiveTrackColor: context.primaryColor.withOpacity(0.2),
                              inactiveThumbColor: context.primaryColor.withOpacity(0.5),
                              onChanged: (val) {
                                addBrandController.isStatus = val.obs;
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
                            if (addBrandController.imageFile.value.path.isNotEmpty || addBrandController.brandImage.isNotEmpty) {
                              hideKeyBoardWithoutContext();
                              addBrandController.addUpdateBrand();
                            } else {
                              toast(locale.value.selectTheBrandImage);
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
          Obx(() => const LoaderWidget().visible(addBrandController.isLoading.value)),
        ],
      ),
    );
  }
}
