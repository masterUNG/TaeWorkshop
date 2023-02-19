import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taewhorkshop/models/user_model.dart';

class AppController extends GetxController {
  RxList<String?> typeUserChooses = <String?>[null].obs;
  RxList<Position> positions = <Position>[].obs;
  RxList<UserModle> userModels = <UserModle>[].obs;
  RxInt indexDrawer = 0.obs;
  RxInt indexBottom = 0.obs;
  RxList<UserModle> shopUserModels = <UserModle>[].obs;
  RxMap<MarkerId, Marker> mapMarker = <MarkerId, Marker>{}.obs;
}
