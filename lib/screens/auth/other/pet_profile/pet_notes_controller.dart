// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/common_base.dart';
import '../../model/login_response.dart';
import '../../model/pet_note_model.dart';
import '../../services/pet_service_apis.dart';

class PetNotesController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();
  Rx<NotePetModel> selectedNote = NotePetModel(createdbyUser: UserData(), isPrivate: false.obs).obs;
  Rx<Future<List<NotePetModel>>> notes = Future(() => <NotePetModel>[]).obs;
  RxList<NotePetModel> getNotes = RxList();
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    if (Get.arguments is int) {
      getNoteApi(petId: Get.arguments);
    }
  }

  //get note apis
  getNoteApi({
    required int petId,
    bool showLoader = false,
  }) async {
    if (showLoader) {
      isLoading(true);
    }
    await notes(PetService.getNoteApi(
      petId: petId,
      page: page.value,
      notes: getNotes,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }

  addEditNote({required int petId}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": !selectedNote.value.id.isNegative ? selectedNote.value.id : "",
      "pet_id": petId,
      "title": titleCont.text.trim(),
      "description": noteCont.text.trim(),
      "is_private": selectedNote.value.isPrivate.value.getIntBool()
    };

    PetService.addNoteApi(request: req).then((value) async {
      getNoteApi(petId: petId, showLoader: true);
      titleCont.clear();
      noteCont.clear();
      Get.back();
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  deleteNote({required int petId, bool isFromEditNote = false}) async {
    isLoading(true);
    await PetService.deleteNote(id: selectedNote.value.id).then((value) async {
      getNoteApi(petId: petId, showLoader: true);
      titleCont.clear();
      noteCont.clear();
      if (isFromEditNote) Get.back();
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }
}
