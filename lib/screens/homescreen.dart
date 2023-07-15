import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterMapApp extends StatefulWidget {
  final Position currentPosition;

  FlutterMapApp(this.currentPosition);
  @override
  _FlutterMapAppState createState() => _FlutterMapAppState();
}

class _FlutterMapAppState extends State<FlutterMapApp> {
  GoogleMapController? _mapController;
  List<Marker> _markers = [];
  SharedPreferences? _prefs;

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 2,
  );

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.currentPosition.latitude,
        widget.currentPosition.longitude,
      ),
      zoom: 8,
    );
    loadMarkers();
  }

  Future<void> loadMarkers() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      final markerData = _prefs!.getString('markers');
      if (markerData != null) {
        final decodedData = json.decode(markerData);
        if (decodedData is List<dynamic>) {
          final markersJson = decodedData;
          log(markersJson.toString());
          _markers = markersJson.map((m) => _convertToMarker(m)).toList();
        } else {
          print('Invalid marker data format');
        }
      }
    });
  }

  Marker _convertToMarker(Map<String, dynamic> markerMap) {
    log(markerMap.toString());
    final markerId = MarkerId(markerMap['markerId']);
    final position = LatLng(
      markerMap['position'][0],
      markerMap['position'][1],
    );
    final infoWindow = markerMap['infoWindow'] != null
        ? InfoWindow(
            title: markerMap['infoWindow']['title'],
            onTap: () => showMarkerNoteDialog(markerId),
          )
        : null;
    return Marker(
      markerId: markerId,
      position: position,
      infoWindow: infoWindow!,
      onTap: () => showMarkerNoteDialog(markerId),
    );
  }

  Future<void> saveMarkers() async {
    final markersJson = json.encode(_markers.map((m) => m.toJson()).toList());
    await _prefs!.setString('markers', markersJson);
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void addMarker(LatLng position) {
    final markerId = MarkerId(DateTime.now().millisecondsSinceEpoch.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
      onTap: () => showMarkerNoteDialog(markerId),
    );
    setState(() {
      _markers.add(marker);
    });
    saveMarkers();
  }

  void showMarkerNoteDialog(MarkerId markerId) {
    final markerIndex = _markers.indexWhere((m) => m.markerId == markerId);
    final marker = _markers[markerIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController noteController =
            TextEditingController(text: marker.infoWindow?.title ?? '');

        return AlertDialog(
          title: Text('Marker Note'),
          content: TextField(
            controller: noteController,
            decoration: InputDecoration(hintText: 'Enter note'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  deleteMarker(markerId);
                });
                saveMarkers();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final updatedMarker = marker.copyWith(
                  infoWindowParam: InfoWindow(
                    title: noteController.text,
                    onTap: () => showMarkerNoteDialog(markerId),
                  ),
                );
                setState(() {
                  _markers[markerIndex] = updatedMarker;
                });
                saveMarkers();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteMarker(MarkerId markerId) {
    setState(() {
      _markers.removeWhere((m) => m.markerId == markerId);
    });
    saveMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Interactive Map App'),
        ),
        body: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: _initialCameraPosition,
          markers: Set<Marker>.from(_markers),
          onTap: (position) => addMarker(position),
        ),
      ),
    );
  }
}
