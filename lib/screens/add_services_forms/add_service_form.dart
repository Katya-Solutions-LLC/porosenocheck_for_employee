import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/add_service_controller.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';

import '../../components/app_primary_widget.dart';
import '../../components/bottom_selection_widget.dart';
import '../../components/cached_image_widget.dart';
import '../../components/chat_gpt_loder.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import 'model/category_model.dart';

class AddServiceForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();

  final AddServiceController addServiceController = Get.put(AddServiceController());

  final bool isEdit;

  AddServiceForm({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: isEdit ? locale.value.editService : locale.value.addService,
      isLoading: addServiceController.isLoading,
      body: AnimatedScrollView(
        controller: scrollController,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 60, top: 16),
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.value.serviceImage, style: boldTextStyle(size: 16)),
                12.height,
                Obx(
                  () => addServiceController.imageFile.value.path.isNotEmpty || addServiceController.serviceImage.value.isNotEmpty
                      ? Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: Loader(),
                              ).visible(addServiceController.serviceImage.value.isNotEmpty || addServiceController.imageFile.value.path.isNotEmpty),
                              CachedImageWidget(
                                url: addServiceController.imageFile.value.path.isNotEmpty ? addServiceController.imageFile.value.path : addServiceController.serviceImage.value,
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              ).cornerRadiusWithClipRRect(defaultRadius),
                              Positioned(
                                top: 110 * 3 / 4 + 4,
                                left: 110 * 3 / 4 + 4,
                                child: GestureDetector(
                                  onTap: () {
                                    hideKeyboard(context);
                                    addServiceController.showBottomSheet(context);
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
                                addServiceController.showBottomSheet(context);
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
                AppTextField(
                  title: locale.value.serviceName,
                  textStyle: primaryTextStyle(size: 12),
                  controller: addServiceController.serviceCont,
                  focus: addServiceController.serviceNameFocus,
                  nextFocus: addServiceController.serviceDurationFocus,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(
                    context,
                    hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                        ? "${locale.value.eG}  ${locale.value.pet} ${locale.value.nutrition} ${locale.value.consultation}"
                        : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                            ? "${locale.value.eG}  ${locale.value.flea} ${locale.value.and} ${locale.value.tick} ${locale.value.bath}"
                            : loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                                ? "${locale.value.eG}  ${locale.value.leashTraining}"
                                : "${locale.value.eG}  ${locale.value.serviceName}",
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming) || loginUserData.value.userRole.contains(EmployeeKeyConst.training)),
                16.height,
                Obx(
                  () => AppTextField(
                    title: locale.value.category,
                    textStyle: primaryTextStyle(size: 12),
                    controller: addServiceController.categoryCont,
                    textFieldType: TextFieldType.NAME,
                    readOnly: true,
                    onTap: () async {
                      serviceCommonBottomSheet(
                        context,
                        child: Obx(
                          () => BottomSelectionSheet(
                            title: locale.value.chooseCategory,
                            hintText: locale.value.searchForCategory,
                            controller: addServiceController.searchCont,
                            hasError: addServiceController.hasErrorFetchingCategory.value,
                            onChanged: addServiceController.onCategorySearchChange,
                            isEmpty: addServiceController.isShowFullList ? addServiceController.categoryList.isEmpty : addServiceController.categoryFilterList.isEmpty,
                            errorText: addServiceController.errorMessageCategory.value,
                            isLoading: addServiceController.isLoading,
                            noDataTitle: locale.value.categoryListIsEmpty,
                            noDataSubTitle: locale.value.thereAreNoCategory,
                            onRetry: () {
                              addServiceController.getCategory();
                            },
                            listWidget: Obx(
                              () => veterinaryTypeListWid(
                                addServiceController.isShowFullList ? addServiceController.categoryList : addServiceController.categoryFilterList,
                              ).expand(),
                            ),
                          ),
                        ),
                      );
                    },
                    decoration: inputDecoration(context,
                        hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                            ? "${locale.value.eG}  ${locale.value.videoConsultancy}"
                            : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                                ? "${locale.value.eG}  ${locale.value.bathingAndShampooing}"
                                : "${locale.value.eG} ${locale.value.categoryType}",
                        fillColor: context.cardColor,
                        filled: true,
                        prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                        prefixIcon: addServiceController.selectedVeterinaryType.value.categoryImage.isEmpty && addServiceController.selectedVeterinaryType.value.id.isNegative
                            ? null
                            : CachedImageWidget(
                                url: addServiceController.selectedVeterinaryType.value.categoryImage,
                                height: 35,
                                width: 35,
                                firstName: addServiceController.selectedVeterinaryType.value.name,
                                fit: BoxFit.cover,
                                circle: true,
                                usePlaceholderIfUrlEmpty: true,
                              ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                        suffixIcon: addServiceController.selectedVeterinaryType.value.categoryImage.isNotEmpty && addServiceController.selectedVeterinaryType.value.id.isNegative
                            ? Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))
                            : Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))),
                  ),
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)),
                16.height,
                AppTextField(
                  title: "${locale.value.serviceDuration} ${(locale.value.mins)}",
                  textStyle: primaryTextStyle(size: 12),
                  controller: addServiceController.durationCont,
                  focus: addServiceController.serviceDurationFocus,
                  nextFocus: addServiceController.defaultPriceFocus,
                  textFieldType: TextFieldType.NUMBER,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: inputDecoration(
                    context,
                    hintText: "${locale.value.eG} 30 ${locale.value.min}",
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return locale.value.thisFieldIsRequired;
                    } else if (value.contains('.') || value.startsWith('-')) {
                      return 'The input duration is invalid'; //TODO: string
                    }
                    return null;
                  },
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)),
                16.height,
                AppTextField(
                  title: locale.value.defaultPrice,
                  textStyle: primaryTextStyle(size: 12),
                  controller: addServiceController.priceCont,
                  textFieldType: TextFieldType.NUMBER,
                  focus: addServiceController.defaultPriceFocus,
                  nextFocus: addServiceController.descriptionFocus,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: inputDecoration(
                    context,
                    hintText: "${locale.value.eG} \$90.00",
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return locale.value.thisFieldIsRequired;
                    } else if (value.startsWith('.') || value.startsWith('-')) {
                      return locale.value.theInputtedPriceIsInvalid;
                    } else if (value.toDouble() == 0.0) {
                      return 'Value must be greater than or equal to 0'; //TODO: string
                    }
                    return null;
                  },
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)),
                16.height,
                AppTextField(
                  title: locale.value.description,
                  textStyle: primaryTextStyle(size: 12),
                  controller: addServiceController.descriptionCont,
                  focus: addServiceController.descriptionFocus,
                  minLines: 3,
                  nextFocus: addServiceController.descriptionFocus,
                  textFieldType: TextFieldType.MULTILINE,
                  enableChatGPT: appConfigs.value.enableChatGpt,
                  promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
                  testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
                  loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                  decoration: inputDecoration(
                    context,
                    hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                        ? "${locale.value.eG}  ${locale.value.healthyDogFeedingGuide}"
                        : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                            ? "${locale.value.eG}  ${locale.value.targetedTreatmentToEliminate} & ${locale.value.ticks}"
                            : loginUserData.value.userRole.contains(EmployeeKeyConst.training)
                                ? "${locale.value.eG}  ${locale.value.teachingPetsToWalk}"
                                : "${locale.value.eG}  ${locale.value.description}",
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming) || loginUserData.value.userRole.contains(EmployeeKeyConst.training)),
                16.height,
                AppButton(
                  width: Get.width,
                  color: primaryColor,
                  onTap: () {
                    if (!addServiceController.isLoading.value) {
                      if (addServiceController.imageFile.value.path.isNotEmpty || addServiceController.serviceImage.isNotEmpty) {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          /// Add Or Edit Service Api Call
                          if (loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)) {
                            addServiceController.addServices();
                          } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.training)) {
                            addServiceController.addServicesTraining();
                          }
                        }
                      } else {
                        toast(locale.value.pleaseSelectAServiceImage);
                        /// Open Gallery
                        hideKeyboard(context);
                        addServiceController.showBottomSheet(context);
                      }
                    }
                  },
                  child: Text(addServiceController.isEdit.value ? locale.value.update : locale.value.save, style: primaryTextStyle(color: white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget veterinaryTypeListWid(List<ShopCategoryModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].name,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].categoryImage, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            addServiceController.selectedVeterinaryType(list[index]);
            addServiceController.categoryCont.text = list[index].name;
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }
}
