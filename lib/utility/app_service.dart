import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taewhorkshop/models/user_model.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/utility/app_dialog.dart';
import 'package:taewhorkshop/widgets/widget_text_button.dart';

class AppService {
  Future<void> readAllShop() async {
    AppController appController = Get.put(AppController());
    if (appController.shopUserModels.isNotEmpty) {
      appController.shopUserModels.clear();
      appController.mapMarker.clear();
    }

    await FirebaseFirestore.instance
        .collection('user')
        .where('typeUser', isEqualTo: 'Shopper')
        .get()
        .then((value) {
      int i = 0;
      for (var element in value.docs) {
        UserModle modle = UserModle.fromMap(element.data());
        appController.shopUserModels.add(modle);

        MarkerId markerId = MarkerId(i.toString());
        appController.mapMarker[markerId] = Marker(
            markerId: markerId,
            position: LatLng(modle.geoPoint.latitude, modle.geoPoint.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(240),
            infoWindow:
                InfoWindow(title: appController.shopUserModels.last.name));
        i++;
      }
    });
  }

  Future<UserModle?> findUserModel({required String uidLogin}) async {
    AppController appController = Get.put(AppController());
    UserModle? userModle;
    var result =
        await FirebaseFirestore.instance.collection('user').doc(uidLogin).get();
    userModle = UserModle.fromMap(result.data()!);
    appController.userModels.add(userModle);
    return userModle;
  }

  Future<void> findPosition({required BuildContext context}) async {
    bool locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;
    AppController appController = Get.put(AppController());

    if (locationServiceEnable) {
      // Enable Location
      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        //ไม่อนุญาติเลย
        dialogShareLocation(context);
      } else {
        if (locationPermission == LocationPermission.denied) {
          locationPermission = await Geolocator.requestPermission();
          if ((locationPermission != LocationPermission.always) &&
              (locationPermission != LocationPermission.whileInUse)) {
            dialogShareLocation(context);
          } else {
            //หาพิกัด
            await Geolocator.getCurrentPosition().then((value) {
              appController.positions.add(value);
            });
          }
        } else {
          //หาพิกัด
          await Geolocator.getCurrentPosition().then((value) {
            appController.positions.add(value);
          });
        }
      }
    } else {
      // Disble Location
      AppDialog(context: context).normalDialot(
          title: 'Disible Location',
          detail: 'Please Enable Location',
          actionWidget: WidgetTextButton(
            label: 'Enable Location',
            pressFunc: () {
              Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void dialogShareLocation(BuildContext context) {
    AppDialog(context: context).normalDialot(
        title: 'ไม่เปิดแชร์ Location',
        detail: 'Please แชร์ Location ด้วยคะ',
        actionWidget: WidgetTextButton(
          label: 'Open Share Location',
          pressFunc: () {
            Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }
}
