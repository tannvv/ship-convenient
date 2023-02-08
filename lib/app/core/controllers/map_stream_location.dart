import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class MapStreamLocation {
  StreamSubscription<Position>? _positionStream;
  LocationSettings? _locationSettings;
  late Function(Position?) _onPositionChanged;

  MapStreamLocation(
      {required Function(Position?) onPositionChanged, bool isPause = true}) {
    debugPrint('Map position stream: init');
    _onPositionChanged = onPositionChanged;
    _init();
    pausePositionStream();
  }

  void _init() {
    _locationSettings =
        AndroidSettings(intervalDuration: const Duration(seconds: 8));

    _positionStream =
        Geolocator.getPositionStream(locationSettings: _locationSettings)
            .listen(
      (Position? position) async {
        debugPrint(position == null
            ? 'Map position stream: unknown'
            : 'Map position stream: ${position.latitude.toString()}, ${position.longitude.toString()}');

        await _onPositionChanged(position);
      },
    );
  }

  void pausePositionStream() {
    debugPrint('Map position stream: pause');
    if (!(_positionStream?.isPaused ?? true)) {
      _positionStream?.pause();
    }
  }

  void resumePositionStream() {
    debugPrint('Map position stream: resume');
    if (_positionStream?.isPaused ?? true) {
      _positionStream?.resume();
    }
  }

  void close() {
    _positionStream?.cancel();
  }
}
