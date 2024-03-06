import 'package:geolocator/geolocator.dart';

Future<List> getCurrentCoordinates() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return [position.latitude, position.longitude];
  } catch (e) {
    print('Error getting location: $e');
    return [];
  }
}
