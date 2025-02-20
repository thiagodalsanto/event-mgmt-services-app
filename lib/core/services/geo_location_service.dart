import 'dart:io';
import 'package:event_mgmt_services_app/core/exceptions/location_disabled.dart';
import 'package:event_mgmt_services_app/core/exceptions/location_permisson_denied.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  // Check if location services are enabled
  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Request location permission
  static Future<LocationPermission> requestPermission() async {
    if (await GeoLocationService.userPermittedGeoLocation()) {
      return await Geolocator.checkPermission();
    }
    return await Geolocator.requestPermission();
  }

  static Future<bool> userPermittedGeoLocation() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }

  // Generic method to call the correct platform-specific method
  static Future<Position> getCurrentLocation() async {
    if (Platform.isAndroid) {
      return await getLocationAndroid();
    } else if (Platform.isIOS) {
      return await getLocationIOS();
    } else {
      throw UnsupportedError('Geolocation is not supported on this platform');
    }
  }

  // Android-specific method
  static Future<Position> getLocationAndroid() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException('Location services are disabled on Android.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw LocationPermissionDeniedException('Location permission denied on Android.');
      }
    }

    // Android-specific location settings
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Adjust the distance filter as needed
    );

    // Fetch the current position for Android
    return await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  }

  // iOS-specific method
  static Future<Position> getLocationIOS() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationDisabledException('Location services are disabled on iOS.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw LocationPermissionDeniedException('Location permission denied on iOS.');
      }
    }

    // iOS-specific location settings
    AppleSettings appleSettings = AppleSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Adjust the distance filter as needed
    );

    // Fetch the current position for iOS
    return await Geolocator.getCurrentPosition(locationSettings: appleSettings);
  }
}
