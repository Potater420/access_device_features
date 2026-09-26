import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Cairo Governorate, Egypt
  static const LatLng _cairoLocation = LatLng(30.0444, 31.2357);

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _cairoLocation,
    zoom: 12,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('cairo_marker'),
      position: _cairoLocation,
      icon: BitmapDescriptor.defaultMarker, // red by default
      infoWindow: InfoWindow(title: 'Cairo Governorate, Egypt'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map'), centerTitle: true),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
