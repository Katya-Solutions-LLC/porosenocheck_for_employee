import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/main.dart';

import '../../../../utils/common_base.dart';
import 'add_units_tags_controller.dart';

class AddUnitTagsScreen extends StatefulWidget {
  final bool isEdit;

  const AddUnitTagsScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<AddUnitTagsScreen> createState() => _AddUnitTagsScreenState();
}

class _AddUnitTagsScreenState extends State<AddUnitTagsScreen> {
  final AddUnitTagController addUnitTagController = Get.put(AddUnitTagController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Get.delete<AddUnitTagController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: Get.arguments['isFromTag'] == true
          ? widget.isEdit
              ? locale.value.updateTag
              : locale.value.addTag
          : widget.isEdit
              ? locale.value.updateUnit
              : locale.value.addUnit,
      body: Stack(
        children: [
          AnimatedScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextField(
                      title: Get.arguments['isFromTag'] == true ? locale.value.tagName : locale.value.unitName,
                      controller: addUnitTagController.nameCont,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: Get.arguments['isFromTag'] == true ? locale.value.enterTheTagName : locale.value.enterTheUnitName,
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
                            value: addUnitTagController.isStatus.value,
                            activeColor: context.primaryColor,
                            inactiveTrackColor: context.primaryColor.withOpacity(0.2),
                            inactiveThumbColor: context.primaryColor.withOpacity(0.5),
                            onChanged: (val) {
                              addUnitTagController.isStatus = val.obs;
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
                          addUnitTagController.addUpdateUnitTags(isFromTag: Get.arguments['isFromTag'] == true ? true : false);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Obx(() => const LoaderWidget().visible(addUnitTagController.isLoading.value)),
        ],
      ),
    );
  }
}
