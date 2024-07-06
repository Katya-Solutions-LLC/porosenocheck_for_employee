import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../main.dart';
import '../../model/pet_owners_res.dart';

class PetCard extends StatelessWidget {
  final PetData petProfile;
  const PetCard({super.key, required this.petProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            32.height,
            Hero(
              tag: "${petProfile.name}${petProfile.id}",
              child: CachedImageWidget(
                url: petProfile.petImage,
                firstName: petProfile.name,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
                circle: true,
              ),
            ),
            16.height,
            Text(petProfile.name, style: primaryTextStyle(size: 18)),
            8.height,
            Text('${locale.value.breed}: ${petProfile.breed}', style: secondaryTextStyle(), textAlign: TextAlign.center),
            32.height,
          ],
        ));
  }
}
