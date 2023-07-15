import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentPosition() async {
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  return await geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
