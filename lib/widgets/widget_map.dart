// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class WidgetMap extends StatelessWidget {
  const WidgetMap({
    Key? key,
    this.mapMarkers,
    this.setCircle,
  }) : super(key: key);

  final Map<MarkerId, Marker>? mapMarkers;
  final Set<Circle>? setCircle;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('position ---> ${appController.positions.length}');

          Map<MarkerId, Marker> map = {};
          MarkerId markerId = const MarkerId('id');
          map[markerId] = Marker(
            markerId: markerId,
            position: LatLng(appController.positions.last.latitude,
                appController.positions.last.longitude),
            infoWindow: InfoWindow(
                title: 'คุณอยู่ที่นี่',
                snippet:
                    'lat = ${appController.positions.last.latitude}, lng = ${appController.positions.last.longitude}'),
          );

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(appController.positions.last.latitude,
                  appController.positions.last.longitude),
              zoom: 14,
            ),
            onMapCreated: (controller) {},
            markers: mapMarkers == null ? Set<Marker>.of(map.values) : Set<Marker>.of(mapMarkers!.values) ,
            circles: setCircle ?? {},
          );
        });
  }
}
