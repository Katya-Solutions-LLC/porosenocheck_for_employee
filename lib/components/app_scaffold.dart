import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/common_base.dart';
import 'body_widget.dart';

class AppScaffold extends StatelessWidget {
  final bool hideAppBar;
  //
  final Widget? leadingWidget;
  final Widget? appBarTitle;
  final List<Widget>? actions;
  final bool isCenterTitle;
  final bool automaticallyImplyLeading;
  final double? appBarelevation;
  final String? appBartitleText;
  final int? appBarTitleTextSize;
  final Color? appBarbackgroundColor;
  //
  final Widget body;
  final Color? scaffoldBackgroundColor;
  final RxBool? isLoading;
  //
  final Widget? bottomNavBar;
  final Widget? fabWidget;
  final bool hasLeadingWidget;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomPadding;

  const AppScaffold({
    Key? key,
    this.hideAppBar = false,
    //
    this.leadingWidget,
    this.appBarTitle,
    this.actions,
    this.appBarelevation = 0,
    this.appBartitleText,
    this.appBarTitleTextSize,
    this.appBarbackgroundColor,
    this.isCenterTitle = false,
    this.hasLeadingWidget = true,
    this.automaticallyImplyLeading = false,
    //
    required this.body,
    this.isLoading,
    //
    this.bottomNavBar,
    this.fabWidget,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomPadding,
    this.scaffoldBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
      appBar: hideAppBar
          ? null
          : PreferredSize(
              preferredSize: Size(Get.width, 66),
              child: AppBar(
                elevation: appBarelevation,
                automaticallyImplyLeading: automaticallyImplyLeading,
                backgroundColor: appBarbackgroundColor ?? context.scaffoldBackgroundColor,
                centerTitle: isCenterTitle,
                titleSpacing: 2,
                title: appBarTitle ??
                    Text(
                      appBartitleText ?? "",
                      style: primaryTextStyle(size: appBarTitleTextSize ?? 16),
                    ).paddingLeft(hasLeadingWidget ? 0 : 16),
                actions: actions,
                leading: leadingWidget ?? (hasLeadingWidget ? backButton(context) : null),
              ).paddingTop(10),
            ),
      backgroundColor: scaffoldBackgroundColor ?? context.scaffoldBackgroundColor,
      body: Body(
        isLoading: isLoading ?? false.obs,
        child: body,
      ),
      bottomNavigationBar: bottomNavBar,
      floatingActionButton: fabWidget,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
