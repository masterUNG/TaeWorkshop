import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taewhorkshop/utility/app_controller.dart';
import 'package:taewhorkshop/utility/app_service.dart';
import 'package:taewhorkshop/widgets/widget_map.dart';
import 'package:taewhorkshop/widgets/widget_text.dart';

class BodyMap extends StatefulWidget {
  const BodyMap({super.key});

  @override
  State<BodyMap> createState() => _BodyMapState();
}

class _BodyMapState extends State<BodyMap> {
  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    processFindPositionAndMarker();
  }

  void processFindPositionAndMarker() {
    AppService().findPosition(context: context).then((value) {
      
      MarkerId markerId = const MarkerId('id');
      controller.mapMarker[markerId] = Marker(
        markerId: markerId,
        position: LatLng(controller.positions.last.latitude,
            controller.positions.last.longitude),
        infoWindow: InfoWindow(
            title: 'คุณอยู่ที่นี่',
            snippet:
                'lat = ${controller.positions.last.latitude}, lng = ${controller.positions.last.longitude}'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('## mapMarker --> ${appController.mapMarker.length}');
            return Scaffold(
              body: SizedBox(
                width: boxConstraints.maxWidth,
                height: boxConstraints.maxHeight,
                child: (appController.positions.isEmpty) ||
                        (appController.shopUserModels.isEmpty)
                    ? const SizedBox()
                    : WidgetMap(
                        mapMarkers: appController.mapMarker,
                        setCircle: {
                          Circle(
                            circleId: const CircleId('id'),
                            center: LatLng(
                                appController.positions.last.latitude,
                                appController.positions.last.longitude),
                            radius: 2000,
                            fillColor: Colors.green.withOpacity(0.25),
                            strokeWidth: 1,
                          )
                        },
                      ),
              ),
            );
          });
    });
  }
}
