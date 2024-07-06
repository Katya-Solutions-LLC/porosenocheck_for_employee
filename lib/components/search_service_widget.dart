import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../screens/add_services_forms/service_list_controller.dart';
import '../utils/common_base.dart';

class SearchServiceWidget extends StatelessWidget {
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onClearButton;
  final ServiceListController serviceController;

  const SearchServiceWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.onFieldSubmitted,
    this.onClearButton,
    required this.serviceController,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: serviceController.searchServiceCont,
      textFieldType: TextFieldType.OTHER,
      textInputAction: TextInputAction.done,
      textStyle: primaryTextStyle(),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (p0) {
        serviceController.isSearchServiceText(serviceController.searchServiceCont.text.trim().isNotEmpty);
        serviceController.searchServiceStream.add(p0);
      },
      suffix: Obx(
            () => appCloseIconButton(
          context,
          onPressed: () {
            if (onClearButton != null) {
              onClearButton!.call();
            }
            hideKeyboard(context);
            serviceController.searchServiceCont.clear();
            serviceController.isSearchServiceText(serviceController.searchServiceCont.text.trim().isNotEmpty);
            serviceController.page(1);
            serviceController.getServiceList();
          },
          size: 11,
        ).visible(serviceController.isSearchServiceText.value),
      ),
      decoration: inputDecorationWithOutBorder(
        context,
        hintText: hintText ?? locale.value.searchHere,
        filled: true,
        fillColor: context.cardColor,
        prefixIcon: commonLeadingWid(imgPath: Assets.iconsIcSearch, icon: Icons.search_outlined, size: 18).paddingAll(14),
      ),
    );
  }
}
