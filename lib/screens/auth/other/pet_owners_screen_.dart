import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/auth/other/pet_owners_screen_controller.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/flutter_image_stack_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../model/pet_owners_res.dart';
import 'pet_profile/my_pets_screen.dart';

class PetOwnersScreen extends StatelessWidget {
  PetOwnersScreen({Key? key}) : super(key: key);
  final PetOwnersController petOwnersController = Get.put(PetOwnersController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: "Pet Owners",
      isLoading: petOwnersController.isLoading,
      body: Obx(() => SnapHelperWidget(
          future: petOwnersController.getPetOwners.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                petOwnersController.page = 1;
                petOwnersController.init();
              },
            ).paddingSymmetric(horizontal: 32);
          },
          loadingWidget: const LoaderWidget(),
          onSuccess: (petOwners) {
            petOwners.removeWhere((element) => element.pets.isEmpty);
            return AnimatedListView(
              shrinkWrap: true,
              itemCount: petOwners.length,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              emptyWidget: NoDataWidget(
                title: locale.value.noDataFound,
                subTitle: locale.value.currentlyThereAreNo,
                titleTextStyle: primaryTextStyle(),
                imageWidget: const EmptyStateWidget(),
                retryText: locale.value.reload,
                onRetry: () {
                  petOwnersController.page = 1;
                  petOwnersController.init();
                },
              ).paddingSymmetric(horizontal: 32),
              itemBuilder: (context, index) {
                PetOwner petOwner = petOwners[index];
                List<String> petImgList = petOwner.pets.map((e) => e.petImage).toList();
                return GestureDetector(
                  onTap: () {
                    Get.to(() => MyPetsScreen(petOwner: petOwner));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: boxDecorationDefault(color: Colors.white, shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: CachedImageWidget(
                              url: petOwner.profileImage,
                              firstName: petOwner.firstName,
                              lastName: petOwner.lastName,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              circle: true,
                            ),
                          ),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    petOwner.fullName,
                                    style: primaryTextStyle(decoration: TextDecoration.none),
                                  ),
                                  4.width,
                                  // Text('- ${petOwner.data.notificationDetail.bookingServicesNames}', style: primaryTextStyle()).visible(petOwner.data.notificationDetail.bookingServicesNames.isNotEmpty),
                                ],
                              ),
                              4.height,
                              FlutterImageStack(
                                imageList: petImgList,
                                totalCount: petImgList.length,
                                itemCount: 6,
                                showTotalCount: true,
                                itemRadius: 25,
                                itemBorderWidth: 1,
                                itemBorderColor: primaryColor,
                                onCallBack: () {},
                                backgroundColor: context.scaffoldBackgroundColor,
                                extraCountTextStyle: secondaryTextStyle(),
                              )
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                      commonDivider.paddingSymmetric(vertical: 16),
                    ],
                  ),
                );
              },
              onNextPage: () {
                if (!petOwnersController.isLastPage.value) {
                  petOwnersController.page++;
                  petOwnersController.init(showLoader: false);
                }
              },
              onSwipeRefresh: () async {
                petOwnersController.page = 1;
                return await petOwnersController.init(showLoader: false);
              },
            );
          })),
    );
  }
}
