// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/main.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';
import '../utils/common_base.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController searchCont = TextEditingController();
  final String? hintText;
  SearchWidget({super.key, this.hintText});
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: searchCont,
      textFieldType: TextFieldType.OTHER,
      textStyle: secondaryTextStyle(color: primaryTextColor),
      decoration: inputDecorationWithOutBorder(
        context,
        hintText: hintText ?? locale.value.searchHere,
        filled: true,
        fillColor: context.cardColor,
        prefixIcon: Image.asset(
          Assets.iconsIcSearch,
          errorBuilder: (context, error, stackTrace) => const SizedBox(),
        ).paddingOnly(left: 8, top: 8, bottom: 8),
        // prefixIcon: const Icon(Icons.search_outlined, size: 15),
      ),
    );
  }
}
