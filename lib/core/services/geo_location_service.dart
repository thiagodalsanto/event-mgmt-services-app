import 'dart:io';
import 'package:calendar_mgmt_services_app/core/exceptions/location_disabled.dart';
import 'package:calendar_mgmt_services_app/core/exceptions/location_permisson_denied.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<LocationPermission> requestPermission() async {
    if (await GeoLocationService.userPermittedGeoLocation()) {
      return await Geolocator.checkPermission();
    }
    return await Geolocator.requestPermission();
  }

  static Future<bool> userPermittedGeoLocation() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  static Future<Position> getCurrentLocation() async {
    if (Platform.isAndroid) {
      return await getLocationAndroid();
    } else if (Platform.isIOS) {
      return await getLocationIOS();
    } else {
      throw UnsupportedError('Geolocation is not supported on this platform');
    }
  }

  static Future<Position> getLocationAndroid() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException(
          'Location services are disabled on Android.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw LocationPermissionDeniedException(
            'Location permission denied on Android.');
      }
    }

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  static Future<Position> getLocationIOS() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException('Location services are disabled on iOS.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw LocationPermissionDeniedException(
            'Location permission denied on iOS.');
      }
    }

    AppleSettings appleSettings = AppleSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    return await Geolocator.getCurrentPosition(locationSettings: appleSettings);
  }
}
