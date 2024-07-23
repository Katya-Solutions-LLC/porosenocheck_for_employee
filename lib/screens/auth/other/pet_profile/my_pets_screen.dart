import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/auth/model/pet_owners_res.dart';

import '../../../../components/app_scaffold.dart';
import '../../../../main.dart';
import 'pet_card_comp.dart';
import 'pet_profile_screen.dart';

class MyPetsScreen extends StatelessWidget {
  final PetOwner petOwner;

  const MyPetsScreen({Key? key, required this.petOwner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: "${petOwner.firstName}'${locale.value.sPets}",
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          padding: const EdgeInsets.only(bottom: 50),
          children: [
            16.height,
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: List.generate(petOwner.pets.length, (index) {
                PetData petProfile = petOwner.pets[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => PetProfileScreen(petData: petProfile), arguments: petProfile.id);
                  },
                  borderRadius: radius(),
                  child: PetCard(petProfile: petProfile),
                );
              }),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
