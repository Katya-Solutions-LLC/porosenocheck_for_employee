// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import '../../../../components/app_scaffold.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../components/common_profile_widget.dart';
import '../../../../components/loader_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/empty_error_state_widget.dart';
import '../../model/pet_owners_res.dart';
import 'add_notes.dart';
import 'pet_notes_controller.dart';

class PetProfileScreen extends StatelessWidget {
  PetProfileScreen({Key? key, required this.petData}) : super(key: key);
  PetData petData;
  PetNotesController petNotesController = Get.put(PetNotesController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.profile,
      body: AnimatedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        onSwipeRefresh: () async {
          petNotesController.page(1);
          return await petNotesController.getNoteApi(petId: petData.id);
        },
        children: [
          ProfilePicWidget(
            heroTag: "${petData.name}${petData.id}",
            profileImage: petData.petImage,
            firstName: petData.name,
            userName: petData.name,
            showCameraIconOnCornar: false,
            subInfo: "${locale.value.breed}: ${petData.breed}",
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              54.height,
              Container(
                height: 90,
                decoration: boxDecorationDefault(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: context.cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      attributesWid(title: locale.value.gender, data: petData.gender.capitalizeFirstLetter()),
                      const VerticalDivider(color: borderColor, indent: 15, endIndent: 15),
                      attributesWid(title: locale.value.birthday, data: petData.dateOfBirth.dateInMMMMDyyyyFormat),
                      const VerticalDivider(color: borderColor, indent: 15, endIndent: 15),
                      attributesWid(title: locale.value.weight, data: "${petData.weight.toString()} ${petData.weightUnit.toString()}"),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      16.width,
                      Text('${locale.value.notesFor} ${petData.name}', style: primaryTextStyle()),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      /* petNotesController.selectedNote(NotePetModel());*/
                      Get.to(() => AddNote(petData: petData));
                    },
                    child: Text(locale.value.addNote, style: primaryTextStyle(color: primaryColor, decorationColor: primaryColor)),
                  )
                ],
              ),
              Obx(() => SnapHelperWidget(
                  future: petNotesController.notes.value,
                  errorBuilder: (error) {
                    return NoDataWidget(
                      title: error,
                      retryText: locale.value.reload,
                      imageWidget: const ErrorStateWidget(),
                      /* onRetry: () {
                        petNotesController.getNoteApi();
                      },*/
                    ).paddingSymmetric(horizontal: 16);
                  },
                  loadingWidget: const LoaderWidget(),
                  onSuccess: (notes) {
                    return notes.isEmpty
                        ? NoDataWidget(
                            title: locale.value.noNewNotes,
                            subTitle: "${locale.value.thereAreCurrentlyNoNotes} ${petData.name}",
                            imageWidget: const EmptyStateWidget(),
                            retryText: locale.value.reload,
                            /*  onRetry: () {
                              petNotesController.page(1);
                              petNotesController.isLoading(true);
                              petNotesController.getNoteApi();
                            },*/
                          ).paddingSymmetric(horizontal: 16)
                        : Obx(
                            () => AnimatedListView(
                              shrinkWrap: true,
                              itemCount: notes.length,
                              listAnimationType: ListAnimationType.FadeIn,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext contex, index) {
                                return Container(
                                  decoration: boxDecorationDefault(color: context.cardColor),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CachedImageWidget(
                                                    url: notes[index].createdbyUser.profileImage,
                                                    height: 22,
                                                    width: 22,
                                                    circle: true,
                                                    radius: 22,
                                                    fit: BoxFit.cover,
                                                  ).visible(notes[index].createdbyUser.profileImage.isNotEmpty),
                                                  Text(notes[index].createdbyUser.userName, style: secondaryTextStyle()).paddingLeft(12).visible(notes[index].createdbyUser.userName.isNotEmpty),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      petNotesController.selectedNote(notes[index]);
                                                      petNotesController.titleCont.text = petNotesController.selectedNote.value.title;
                                                      petNotesController.noteCont.text = petNotesController.selectedNote.value.description;
                                                      Get.to(() => AddNote(petData: petData));
                                                    },
                                                    child: commonLeadingWid(imgPath: Assets.iconsIcEditReview, icon: Icons.edit_outlined, size: 20),
                                                  ),
                                                  16.width,
                                                  GestureDetector(
                                                    onTap: () {
                                                      showConfirmDialogCustom(
                                                        getContext,
                                                        primaryColor: primaryColor,
                                                        negativeText: locale.value.cancel,
                                                        positiveText: locale.value.yes,
                                                        onAccept: (_) {
                                                          petNotesController.selectedNote(notes[index]);
                                                          petNotesController.deleteNote(petId: petData.id);
                                                        },
                                                        dialogType: DialogType.DELETE,
                                                        title: locale.value.areYouSureWantDeleteNote,
                                                      );
                                                    },
                                                    child: commonLeadingWid(imgPath: Assets.iconsIcDelete, color: Colors.redAccent, icon: Icons.delete_outline, size: 20),
                                                  ),
                                                ],
                                              ).visible(notes[index].createdBy == loginUserData.value.id),
                                            ],
                                          ).paddingBottom(8),
                                          Text(notes[index].title, textAlign: TextAlign.left, style: primaryTextStyle()),
                                          8.height,
                                          Text(notes[index].description, textAlign: TextAlign.left, style: secondaryTextStyle()),
                                        ],
                                      ).paddingAll(16).expand(),
                                    ],
                                  ),
                                ).paddingTop(index == 0 ? 0 : 12);
                              },
                              onNextPage: () {
                                if (!petNotesController.isLastPage.value) {
                                  petNotesController.page(petNotesController.page.value + 1);
                                  petNotesController.getNoteApi(petId: petData.id);
                                }
                              },
                              onSwipeRefresh: () async {
                                petNotesController.page(1);
                                return await petNotesController.getNoteApi(petId: petData.id);
                              },
                            ).paddingSymmetric(horizontal: 16),
                          );
                  })),
              32.height,
            ],
          ),
        ],
        onNextPage: () {
          if (!petNotesController.isLastPage.value) {
            petNotesController.page(petNotesController.page.value + 1);
            petNotesController.getNoteApi(petId: petData.id);
          }
        },
      ),
    );
  }

  Widget attributesWid({
    required String title,
    required String data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, textAlign: TextAlign.center, style: secondaryTextStyle()),
        8.height,
        Text(data.validate(value: "-"), textAlign: TextAlign.center, style: primaryTextStyle()),
      ],
    );
  }

  Widget detailWidget({required String title, required String value, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: secondaryTextStyle()),
        Text(value, style: secondaryTextStyle()),
      ],
    ).paddingBottom(10).visible(value.isNotEmpty);
  }
}
