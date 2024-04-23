import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../utils/google_mpas_tools.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    getMyLocation(isFirst: false);
  }

  var customMarkers = const LatLng(34.51868093513547, 34.12835376940892318);
  double zoom = 5;
  final MapController mapController = MapController();
  final MapController subMapController = MapController();
  TextEditingController searchController = TextEditingController();
  void changeLocation(LatLng point) {
    emit(MapChange());
    customMarkers = point;
    subMapController.move(customMarkers, 10);
    mapController.move(customMarkers, zoom);
    emit(MapChanged());
  }

  void getMyLocation({bool isFirst = true}) async {
    try {
      emit(MapGetMyLocationLoadingState());
      Position location = await GoogleMapsTools().locationPermission();
      customMarkers = LatLng(location.latitude, location.longitude);
      subMapController.move(customMarkers, 10);
      if (isFirst) {
        mapController.move(customMarkers, zoom);
      }

      emit(MapGetMyLocationLoadedState());
    } catch (e) {
      emit(MapGetMyLocationErrorState());
    }
  }

  void zoomIn() {
    emit(MapChange());
    zoom = zoom + 1;
    mapController.move(customMarkers, zoom);
    emit(MapChanged());
  }

  void zoomOut() {
    emit(MapChange());
    zoom = zoom - 1;
    mapController.move(customMarkers, zoom);
    emit(MapChanged());
  }
}
