import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';

import '../../../components/bottom_selection_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import 'add_variation_controller.dart';
import 'model/variation_list_response.dart';

class AddVariationScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bool isEdit;

  AddVariationScreen({super.key, this.isEdit = false});

  final AddVariationController addVariationController = Get.put(AddVariationController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: isEdit ? locale.value.editVariations : locale.value.createVariations,
      isLoading: addVariationController.isLoading,
      body: AnimatedScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 30),
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  title: locale.value.variationName,
                  controller: addVariationController.variationNameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.enterTheLogisticZoneName,
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                ),
                16.height,
                AppTextField(
                  title: locale.value.variationType,
                  textStyle: primaryTextStyle(size: 12),
                  controller: addVariationController.variationTypeCont,
                  textFieldType: TextFieldType.NAME,
                  readOnly: true,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.selectYourProductVariation,
                    fillColor: context.cardColor,
                    filled: true,
                    prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                  ),
                  onTap: () {
                    serviceCommonBottomSheet(
                      context,
                      child: BottomSelectionSheet(
                        title: locale.value.chooseVariationType,
                        hideSearchBar: true,
                        controller: TextEditingController(),
                        hasError: addVariationController.hasError.value,
                        isEmpty: !addVariationController.isLoading.value && addVariationController.variationTypeList.isEmpty,
                        errorText: addVariationController.errorMessage.value,
                        noDataTitle: locale.value.variationTypeNotFound,
                        noDataSubTitle: locale.value.thereAreCurrentlyNoVariation,
                        isLoading: addVariationController.isLoading,
                        onRetry: () {
                          //TODO:
                        },
                        listWidget: AnimatedListView(
                          itemCount: addVariationController.variationTypeList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            String data = addVariationController.variationTypeList[i];
                            log(data);

                            return SettingItemWidget(
                              title: data,
                              titleTextStyle: primaryTextStyle(size: 14),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              onTap: () {
                                // addVariationController.selectedVariationType(data); //TODO: uncomment when set in VariationData model
                                addVariationController.selectedVariationType(data);
                                addVariationController.variationTypeCont.text = data.validate();
                                Get.back();
                              },
                            );
                          },
                        ).expand(),
                      ),
                    );
                  },
                ),
                16.height,
                Obx(
                  () => AnimatedListView(
                    listAnimationType: ListAnimationType.None,
                    itemCount: addVariationController.addVariationsTypeList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      VariationData variationData = addVariationController.addVariationsTypeList[index];

                      return variationsTypeListWidget(context,index: index, variationData: variationData);
                    },
                  ).visible(addVariationController.selectedVariationType.isNotEmpty),
                ),
                Obx(
                  () => AppButton(
                    text: 'Add Values',
                    //TODO: string
                    textStyle: appButtonTextStyleWhite,
                    color: secondaryColor,
                    width: Get.width,
                    onTap: () {
                      addVariationController.isLoading(true);
                      addVariationController.addVariationsTypeList.add(
                        VariationData(
                          index: addVariationController.addVariationsTypeList.length,
                          addVariationCount: addVariationController.addVariationsTypeList.length + 1,
                          variationTypeCont: TextEditingController(),
                          variationTypeFocus: FocusNode(),
                          variationValueCont: TextEditingController(),
                          variationValueFocus: FocusNode(),
                        ),
                      );
                      addVariationController.isLoading(false);
                    },
                  ).paddingBottom(8).visible(addVariationController.selectedVariationType.isNotEmpty),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(locale.value.status, style: primaryTextStyle()).expand(),
                    Obx(
                      () => Switch.adaptive(
                        value: addVariationController.isStatus.value,
                        activeColor: context.primaryColor,
                        inactiveTrackColor: context.primaryColor.withOpacity(0.2),
                        inactiveThumbColor: context.primaryColor.withOpacity(0.5),
                        onChanged: (val) {
                          addVariationController.isStatus.value = !addVariationController.isStatus.value;
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
                      hideKeyBoardWithoutContext();
                      //TODO: Save New Variation Api Call
                      // addVariationController.addUpdateBrand();

                      log('addVariationController.variationTypeCont==== ${addVariationController.variationTypeCont.text}');
                      log('addVariationController.variationNameCont==== ${addVariationController.variationNameCont.text}');

                      addVariationController.addVariationsTypeList.forEachIndexed((element, index) {
                        log('variationTypeValueCont=== ${addVariationController.addVariationsTypeList[index].variationTypeValueCont?.text}');
                        log('variationTypeNameCont=== ${addVariationController.addVariationsTypeList[index].variationTypeNameCont?.text}');
                      });

                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget variationsTypeListWidget(BuildContext ctx, {required index, required VariationData variationData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTextField(
          title: 'Value', //TODO: string
          controller: variationData.variationTypeValueCont,
          textFieldType: TextFieldType.NAME,
          decoration: inputDecoration(
            ctx,
            hintText: '${locale.value.eG} S',
            fillColor: ctx.cardColor,
            filled: true,
          ),
        ).expand(),
        16.width,
        AppTextField(
          title: 'Name', //TODO: string
          controller: variationData.variationTypeNameCont,
          textFieldType: TextFieldType.NAME,
          decoration: inputDecoration(
            ctx,
            hintText: '${locale.value.eG} Small',
            fillColor: ctx.cardColor,
            filled: true,
          ),
        ).expand(),
        8.width,
        buildIconWidget(
          icon: Assets.iconsIcDelete,
          iconColor: cancelStatusColor,
          onTap: () {
            log('variationTypeValueCont=== ${variationData.variationTypeValueCont?.text}');
            log('variationTypeNameCont=== ${variationData.variationTypeNameCont?.text}');
            /*addVariationController.addVariationsTypeList[index].variationTypeValueCont!.text = '';
            addVariationController.addVariationsTypeList[index].variationTypeNameCont!.text = '';
            addVariationController.addVariationsTypeList.removeAt(index);*/
          },
        ).paddingTop(16),
      ],
    ).paddingBottom(16);
  }
}
