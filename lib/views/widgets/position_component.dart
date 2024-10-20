// map_component.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapComponent extends StatelessWidget {
  final LatLng initialLocation;
  final LatLng? currentPosition;
  final Function(GoogleMapController) mapController;

  const MapComponent({
    Key? key,
    required this.initialLocation,
    required this.currentPosition,
    required this.mapController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: mapController,
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: 10,
      ),
      markers: {
        if (currentPosition != null)
          Marker(
            markerId: const MarkerId('currentPosition'),
            position: currentPosition!,
          ),
      },
    );
  }
}
