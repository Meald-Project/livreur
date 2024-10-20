import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_info.dart';

class MapComponent extends StatefulWidget {
  final LatLng initialLocation;

  const MapComponent({
    Key? key,
    required this.initialLocation,
  }) : super(key: key);

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(0, 0);
  final Completer<GoogleMapController> _controllerCompleter = Completer();
  String _locationName = "Unknown location";

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.initialLocation;
    _requestPermission();
    _getCurrentPosition().then((position) {
      if (position != null) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
        _getAddressFromLatLng(_currentPosition).then((address) {
          setState(() {
            _locationName = address;
          });
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      }
    });
  }

  Future<void> _requestPermission() async {
    await Permission.location.request();
  }

  Future<Position?> _getCurrentPosition() async {
    if (await Permission.location.isGranted) {
      LocationSettings locationSettings;

      if (kIsWeb) {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
        );
      } else if (Platform.isAndroid) {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      } else if (Platform.isIOS) {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      try {
        return await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      } catch (e) {
        print('Error getting location: $e');
        return null;
      }
    } else {
      print('Location permission not granted');
      return null;
    }
  }

  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.locality}, ${place.country}";
    }
    return "Address not found";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _controllerCompleter.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 13.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId('currentLocation'),
                position: _currentPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),
        LocationInfoComponent(locationName: _locationName),
      ],
    );
  }
}
