// ignore_for_file: body_might_complete_normally_catch_error

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';

import '../utils/constants.dart';

Future<Position> getUserLocationPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();
  if (!serviceEnabled) {
    //
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
      throw '${locale.value.lbl} ${locale.value.locationPermissionDenied}';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw '${locale.value.lbl} ${locale.value.location} ${locale.value.permissionDeniedPermanently}';
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
    return value;
  }).catchError((e) async {
    return await Geolocator.getLastKnownPosition().then((value) async {
      if (value != null) {
        return value;
      } else {
        throw '${locale.value.lbl} ${locale.value.enableLocation}';
      }
    }).catchError((e) {
      toast(e.toString());
    });
  });
}

Future<String> getUserLocation() async {
  Position position = await getUserLocationPosition().catchError((e) {
    throw e.toString();
  });

  return await buildFullAddressFromLatLong(position.latitude, position.longitude);
}

Future<String> buildFullAddressFromLatLong(double latitude, double longitude) async {
  List<Placemark> placeMark = await placemarkFromCoordinates(latitude, longitude).catchError((e) async {
    log(e);
    throw errorSomethingWentWrong;
  });

  setValue(LATITUDE, latitude);
  setValue(LONGITUDE, longitude);

  Placemark place = placeMark[0];

  log(place.toJson());

  String address = '';

  if (!place.name.isEmptyOrNull && !place.street.isEmptyOrNull && place.name != place.street) address = '${place.name.validate()}, ';
  if (!place.street.isEmptyOrNull) address = '$address${place.street.validate()}';
  if (!place.locality.isEmptyOrNull) address = '$address, ${place.locality.validate()}';
  if (!place.administrativeArea.isEmptyOrNull) address = '$address, ${place.administrativeArea.validate()}';
  if (!place.postalCode.isEmptyOrNull) address = '$address, ${place.postalCode.validate()}';
  if (!place.country.isEmptyOrNull) address = '$address, ${place.country.validate()}';

  setValue(CURRENT_ADDRESS, address);

  return address;
}
