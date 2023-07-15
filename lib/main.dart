import 'package:flutter/material.dart';
import 'package:flutter_map_app/screens/homescreen.dart';
import 'package:geolocator/geolocator.dart';

import 'helpers/helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Position currentPosition = await getCurrentPosition();

  runApp(MyApp(currentPosition: currentPosition));
}

class MyApp extends StatelessWidget {
  final Position currentPosition;

  MyApp({super.key, required this.currentPosition});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterMapApp(currentPosition),
    );
  }
}
