import 'package:flutter/material.dart';
import 'package:flutter_map_app/screens/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterMapApp(),
    );
  }
}
