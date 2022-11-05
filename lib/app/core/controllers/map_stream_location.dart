import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapStreamController extends GetxController {
  Rx<LatLng?> centerLocation = Rx<LatLng?>(null);
  StreamSubscription<MapEvent>? subscription;

  @override
  void onClose() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.onClose();
  }
}
