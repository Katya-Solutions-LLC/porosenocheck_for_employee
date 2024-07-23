// ignore_for_file: body_might_complete_normally_catch_error

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';

import '../../components/app_scaffold.dart';
import '../../components/loader_widget.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../location_service.dart';

class MapScreen extends StatefulWidget {
  final double? latLong;
  final double? latitude;
  final String? address;

  const MapScreen({super.key, this.latLong, this.latitude, this.address});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final CameraPosition _initialLocation = const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  String _currentAddress = '';

  final destinationAddressController = TextEditingController();
  final destinationAddressFocusNode = FocusNode();
  RxBool isLoading = false.obs;
  String _destinationAddress = '';

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      destinationAddressController.text = widget.address.validate();
    }
    afterBuildCreated(() {
      _getCurrentLocation();
    });
  }

  // Method for retrieving the current location
  void _getCurrentLocation() async {
    isLoading(true);
    await getUserLocationPosition().then((position) async {
      setAddress();

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18.0),
        ),
      );

      markers.clear();
      markers.add(Marker(
        markerId: MarkerId(_currentAddress),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Start $_currentAddress', snippet: _destinationAddress),
        icon: BitmapDescriptor.defaultMarker,
      ));

      setState(() {});
    }).catchError((e) {
      toast("1$e");
    });

    isLoading(false);
  }

  // Method for retrieving the address
  Future<void> setAddress() async {
    try {
      Position position = await getUserLocationPosition().catchError((e) {
        //
      });
      _currentAddress = await buildFullAddressFromLatLong(position.latitude, position.longitude).catchError((e) {
        log(e);
      });
      destinationAddressController.text = _currentAddress;
      setValue(LATITUDE, position.latitude);
      setValue(LONGITUDE, position.longitude);
      _destinationAddress = _currentAddress;

      setState(() {});
    } catch (e) {
      log("setAddress $e");
    }
  }

  _handleTap(LatLng point) async {
    isLoading(true);
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(point.toString()),
      position: point,
      infoWindow: const InfoWindow(),
      icon: BitmapDescriptor.defaultMarker,
    ));

    destinationAddressController.text = await buildFullAddressFromLatLong(point.latitude, point.longitude).catchError((e) {
      log(e);
    });

    _destinationAddress = destinationAddressController.text;

    isLoading(false);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        handleBack();
        return Future(() => true);
      },
      child: AppScaffold(
        hasLeadingWidget: true,
        leadingWidget: BackButton(onPressed: () {
          handleBack();
        }),
        appBartitleText: locale.value.chooseYourLocation,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onTap: _handleTap,
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100,
                      child: InkWell(
                        splashColor: context.primaryColor.withOpacity(0.8),
                        child: const SizedBox(width: 50, height: 50, child: Icon(Icons.add)),
                        onTap: () {
                          mapController.animateCamera(CameraUpdate.zoomIn());
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipOval(
                    child: Material(
                      color: Colors.blue.shade100,
                      child: InkWell(
                        splashColor: context.primaryColor.withOpacity(0.8),
                        child: const SizedBox(width: 50, height: 50, child: Icon(Icons.remove)),
                        onTap: () {
                          mapController.animateCamera(CameraUpdate.zoomOut());
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingLeft(10),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.orange.shade100, // button color
                      child: const Icon(Icons.my_location, size: 25).paddingAll(10),
                    ),
                  ).paddingRight(8).onTap(() async {
                    isLoading(true);
                    await getUserLocationPosition().then((value) {
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 18.0),
                        ),
                      );

                      _handleTap(LatLng(value.latitude, value.longitude));
                    }).catchError(onError);

                    isLoading(false);
                  }),
                  8.height,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppTextField(
                        title: locale.value.address,
                        controller: destinationAddressController,
                        focus: destinationAddressFocusNode,
                        // Optional
                        textFieldType: TextFieldType.MULTILINE,
                        decoration: inputDecoration(
                          context,
                          fillColor: context.cardColor,
                          filled: true,
                        ),
                      )
                    ],
                  ),
                  8.height,
                  AppButton(
                    width: Get.width,
                    height: 16,
                    color: primaryColor.withOpacity(0.8),
                    text: locale.value.setAddress.toUpperCase(),
                    textStyle: boldTextStyle(color: white, size: 12),
                    onTap: () {
                      handleBack(isSetAddress: true);
                    },
                  ),
                  8.height,
                ],
              ).paddingAll(16),
            ),
            Obx(() => const LoaderWidget().center().visible(isLoading.value)),
          ],
        ),
      ),
    );
  }

  void handleBack({bool isSetAddress = false}) {
    if (isSetAddress) {
      Get.back(result: destinationAddressController.text);
    } else {
      Get.back(result: "");
    }
  }
}
