// ignore_for_file: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:porosenocheck_employee/screens/auth/model/pet_owners_res.dart';
import '../services/auth_services.dart';

class PetOwnersController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Future<RxList<PetOwner>>> getPetOwners = Future(() => RxList<PetOwner>()).obs;
  RxList<PetOwner> petOwners = RxList();
  int page = 1;
  RxBool isLastPage = false.obs;

  

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init({bool showLoader = true}) async {
    if (showLoader) {
      isLoading(true);
    }
    await getPetOwners(AuthServiceApis.getPetOwners(
      page: page,
      petOwners: petOwners,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }
}
