import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapComponent extends StatefulWidget {
  final LatLng initialLocation;
  final LatLng currentPosition;
  final Function(GoogleMapController) mapController;

  const MapComponent({
    Key? key,
    required this.initialLocation,
    required this.currentPosition,
    required this.mapController,
  }) : super(key: key);

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _googleMapController = controller;
        widget.mapController(controller);
        _googleMapController!.animateCamera(CameraUpdate.newLatLng(widget.initialLocation));
      },
      initialCameraPosition: CameraPosition(
        target: widget.initialLocation,
        zoom: 13.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('currentLocation'),
          position: widget.currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
