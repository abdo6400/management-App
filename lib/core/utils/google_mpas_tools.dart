/*import 'package:baraneq/core/utils/app_enums.dart';
import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/service_locator.dart';
import '../../config/database/cache/cache_consumer.dart';
import '../../config/database/error/failures.dart';
import 'custom_print.dart';

class GoogleMapsTools {
//* * * * * * * * Google Maps Tools * * * * * * * * * * * *//

//camera init value for Google Maps.
  CameraPosition appInitialCameraPosition = const CameraPosition(
    target: LatLng(26.8206, 30.8025),
    zoom: 5,
  );

// convert Position To Address by latitude and longitude.
  Future<Placemark> convertPositionToAddress({
    required double lat,
    required double lon,
  }) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lon,
        localeIdentifier:await sl<CacheConsumer>().getStringData(key: MySharedKeys.language.name));
    Placemark place = placeMarks[0];
    // printTest('$lat,$lon');
    // printTest(place.toString());
    // return '${place.country} ${place.locality}  ${place.subLocality}';
    return place;
  }

// get location permission from user and return position details of user.
  Future<Position> locationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      CustomPrint.printError('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        CustomPrint.printError('Location permissions are denied');

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      CustomPrint.printError(
          'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    // printTest(position.longitude.toString());
    // printTest(position.latitude.toString());
    // printTest(position.toString());

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return position;
  }

// get Location Permission And Convert It To Placemark in one method.
  Future<Either<Failure, Placemark>>
      getLocationPermissionAndConvertItToPlacemark() async {
    try {
      var position = await locationPermission();
      var place = await convertPositionToAddress(
          lat: position.latitude, lon: position.longitude);
      return Right(place);
    } catch (error) {
      return const Left(
          LocationFailure(errorMessage: 'Error with get location'));
    }
  }

  void launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
*/