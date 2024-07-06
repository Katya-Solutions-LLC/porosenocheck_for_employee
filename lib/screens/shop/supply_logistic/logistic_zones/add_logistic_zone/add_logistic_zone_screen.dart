import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/bottom_selection_widget.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/screens/shop/supply_logistic/logistics/model/logistic_list_response.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../model/city_list_response.dart';
import '../model/country_list_response.dart';
import '../model/state_list_response.dart';
import 'add_logistic_zone_controller.dart';
import 'component/select_cities_component.dart';

class AddLogisticZoneScreen extends StatefulWidget {
  final bool isEdit;

  const AddLogisticZoneScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<AddLogisticZoneScreen> createState() => _AddLogisticZoneScreenState();
}

class _AddLogisticZoneScreenState extends State<AddLogisticZoneScreen> {
  final AddLogisticZoneController addLogisticZoneController = Get.put(AddLogisticZoneController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<AddLogisticZoneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: widget.isEdit ? locale.value.editLogisticZone : locale.value.addLogisticZone,
      body: Stack(
        children: [
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: AnimatedScrollView(
              padding: const EdgeInsets.all(16),
              children: [
                AppTextField(
                  title: locale.value.logisticZoneName,
                  controller: addLogisticZoneController.nameCont,
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
                  title: locale.value.logistic,
                  controller: addLogisticZoneController.logisticCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.selectLogistic,
                    fillColor: context.cardColor,
                    filled: true,
                    prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                  ),
                  readOnly: true,
                  onTap: () {
                    serviceCommonBottomSheet(
                      context,
                      child: Obx(
                        () => BottomSelectionSheet(
                          title: locale.value.chooseLogistic,
                          hideSearchBar: true,
                          controller: TextEditingController(),
                          hasError: addLogisticZoneController.hasError.value,
                          isEmpty: !addLogisticZoneController.isLoading.value && addLogisticZoneController.logisticList.isEmpty,
                          errorText: addLogisticZoneController.errorMessage.value,
                          noDataTitle: locale.value.logisticNotFound,
                          noDataSubTitle: locale.value.thereAreCurrentlyNoLogisticAvailable,
                          isLoading: addLogisticZoneController.isLoading,
                          onRetry: () {
                            addLogisticZoneController.getLogistics();
                          },
                          listWidget: AnimatedListView(
                            itemCount: addLogisticZoneController.logisticList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, index) {
                              LogisticData data = addLogisticZoneController.logisticList[index];
                              if (data.id == addLogisticZoneController.logisticZone.value.logisticId) {
                                addLogisticZoneController.selectedLogisticData = data.obs;

                                addLogisticZoneController.logisticCont.text = addLogisticZoneController.selectedLogisticData.value.name.validate();
                                toast(addLogisticZoneController.logisticCont.text.toString(), print: true);
                              }

                              return SettingItemWidget(
                                title: data.name,
                                titleTextStyle: primaryTextStyle(size: 14),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                onTap: () {
                                  addLogisticZoneController.selectedLogisticData(data);
                                  addLogisticZoneController.logisticCont.text = data.name.validate();
                                  Get.back();
                                },
                              );
                            },
                          ).expand(),
                        ),
                      ),
                    );
                  },
                ),
                16.height,
                Row(
                  children: [
                    AppTextField(
                      title: locale.value.country,
                      controller: addLogisticZoneController.countryCont,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: locale.value.selectCountry,
                        fillColor: context.cardColor,
                        filled: true,
                        prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                      ),
                      readOnly: true,
                      onTap: () {
                        serviceCommonBottomSheet(
                          context,
                          child: Obx(
                            () => BottomSelectionSheet(
                              title: locale.value.chooseCountry,
                              hideSearchBar: true,
                              controller: TextEditingController(),
                              hasError: addLogisticZoneController.hasError.value,
                              isEmpty: !addLogisticZoneController.isLoading.value && addLogisticZoneController.countryList.isEmpty,
                              errorText: addLogisticZoneController.errorMessage.value,
                              noDataTitle: locale.value.countryNotFound,
                              noDataSubTitle:locale.value.thereAreCurrentlyNoCountryAvailable,
                              isLoading: addLogisticZoneController.isLoading,
                              onRetry: () {
                                addLogisticZoneController.getLogistics();
                              },
                              listWidget: AnimatedListView(
                                itemCount: addLogisticZoneController.countryList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, index) {
                                  CountryData data = addLogisticZoneController.countryList[index];
                                  return SettingItemWidget(
                                    title: data.name,
                                    titleTextStyle: primaryTextStyle(size: 14),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    onTap: () {
                                      addLogisticZoneController.selectedCountry(data);
                                      addLogisticZoneController.countryCont.text = data.name.validate();
                                      addLogisticZoneController.stateCont.text = "";
                                      addLogisticZoneController.cityCont.text = "";
                                      addLogisticZoneController.stateList.clear();
                                      addLogisticZoneController.cityList.clear();
                                      addLogisticZoneController.getStates(countryId: data.id);
                                      Get.back();
                                    },
                                  );
                                },
                              ).expand(),
                            ),
                          ),
                        );
                      },
                    ).expand(),
                    16.width,
                    AppTextField(
                      title: locale.value.state,
                      controller: addLogisticZoneController.stateCont,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: locale.value.selectState,
                        fillColor: context.cardColor,
                        filled: true,
                        prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                      ),
                      readOnly: true,
                      onTap: () {
                        serviceCommonBottomSheet(
                          context,
                          child: Obx(
                            () => BottomSelectionSheet(
                              title: locale.value.chooseState,
                              hideSearchBar: true,
                              controller: TextEditingController(),
                              hasError: addLogisticZoneController.hasError.value,
                              isEmpty: !addLogisticZoneController.isLoading.value && addLogisticZoneController.stateList.isEmpty,
                              errorText: addLogisticZoneController.errorMessage.value,
                              noDataTitle: locale.value.stateNotFound,
                              noDataSubTitle: locale.value.thereAreCurrentlyNoStateAvailable,
                              isLoading: addLogisticZoneController.isLoading,
                              onRetry: () {
                                addLogisticZoneController.getLogistics();
                              },
                              listWidget: AnimatedListView(
                                itemCount: addLogisticZoneController.stateList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, index) {
                                  StateData data = addLogisticZoneController.stateList[index];
                                  return SettingItemWidget(
                                    title: data.name,
                                    titleTextStyle: primaryTextStyle(size: 14),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    onTap: () {
                                      addLogisticZoneController.selectedState(data);
                                      addLogisticZoneController.stateCont.text = data.name.validate();
                                      addLogisticZoneController.cityCont.text = "";
                                      addLogisticZoneController.cityList.clear();
                                      addLogisticZoneController.getCities(stateId: data.id);
                                      Get.back();
                                    },
                                  );
                                },
                              ).expand(),
                            ),
                          ),
                        );
                      },
                    ).expand(),
                  ],
                ),
                16.height,
                AppTextField(
                  title: locale.value.city,
                  controller: addLogisticZoneController.cityCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.selectCity,
                    fillColor: context.cardColor,
                    filled: true,
                    prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
                  ),
                  readOnly: true,
                  onTap: () {
                    serviceCommonBottomSheet(
                      context,
                      child: Obx(
                        () => BottomSelectionSheet(
                          title: locale.value.chooseCity,
                          hideSearchBar: true,
                          controller: TextEditingController(),
                          hasError: addLogisticZoneController.hasError.value,
                          isEmpty: !addLogisticZoneController.isLoading.value && addLogisticZoneController.cityList.isEmpty,
                          errorText: addLogisticZoneController.errorMessage.value,
                          noDataTitle: locale.value.cityNotFound,
                          noDataSubTitle: locale.value.thereAreCurrentlyNoCityAvailable,
                          isLoading: addLogisticZoneController.isLoading,
                          onRetry: () {
                            addLogisticZoneController.getLogistics();
                          },
                          listWidget: SelectCitiesComponent(
                            onSelectedList: (List<CityData>? value) {
                              addLogisticZoneController.selectedCities(value!.obs);
                              addLogisticZoneController.selectedCitiesName.clear();

                              addLogisticZoneController.selectedCities.forEach((element) {
                                addLogisticZoneController.selectedCitiesName.add(element.name);
                              });
                              log('Cities Name: ${addLogisticZoneController.selectedCitiesName}');

                              addLogisticZoneController.cityCont.text = addLogisticZoneController.selectedCitiesName.join(',');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                16.height,
                AppTextField(
                  title: locale.value.standardDeliveryCharge,
                  controller: addLogisticZoneController.deliveryChargeCont,
                  textFieldType: TextFieldType.NUMBER,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.enterTheStandardDeliveryCharge,
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                ),
                16.height,
                AppTextField(
                  title: locale.value.standardDeliveryTime,
                  controller: addLogisticZoneController.deliveryTimeCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(
                    context,
                    hintText: locale.value.enterTheStandardDeliveryTime,
                    fillColor: context.cardColor,
                    filled: true,
                  ),
                ),
                32.height,
                AppButton(
                  text: locale.value.save,
                  height: 40,
                  color: primaryColor,
                  textStyle: appButtonTextStyleWhite,
                  width: Get.width - context.navigationBarHeight,
                  onTap: () {
                    if (!addLogisticZoneController.isLoading.value) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        addLogisticZoneController.saveLogisticZones();
                      }
                    }
                  },
                ),
                16.height,
              ],
            ),
          ),
          Obx(() => const LoaderWidget().visible(addLogisticZoneController.isLoading.value)),
        ],
      ),
    );
  }
}
