import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../screens/booking_module/booking_list/bookings_controller.dart';
import '../utils/common_base.dart';

class SearchBookingWidget extends StatelessWidget {
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onClearButton;
  final BookingsController bookingsController;

  const SearchBookingWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.onFieldSubmitted,
    this.onClearButton,
    required this.bookingsController,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: bookingsController.searchCont,
      textFieldType: TextFieldType.OTHER,
      textInputAction: TextInputAction.done,
      textStyle: primaryTextStyle(),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (p0) {
        bookingsController.isSearchText(bookingsController.searchCont.text.trim().isNotEmpty);
        bookingsController.searchStream.add(p0);
      },
      suffix: Obx(
        () => appCloseIconButton(
          context,
          onPressed: () {
            if (onClearButton != null) {
              onClearButton!.call();
            }
            hideKeyboard(context);
            bookingsController.searchCont.clear();
            bookingsController.isSearchText(bookingsController.searchCont.text.trim().isNotEmpty);
            bookingsController.page(1);
            bookingsController.getBookingList();
          },
          size: 11,
        ).visible(bookingsController.isSearchText.value),
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
