// livraison_page.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/action_component.dart'; // Import the new ActionComponent
import '../widgets/drawer_component.dart';
import '../widgets/expandable_info_component.dart';
import 'map_scrren_test.dart';

class LivraisonPage extends StatefulWidget {
  const LivraisonPage({super.key});

  @override
  _LivraisonPageState createState() => _LivraisonPageState();
}

class _LivraisonPageState extends State<LivraisonPage> {
  Position? _currentPosition;
  bool _locationPermissionGranted = false;
  final LatLng _tunisiaLocation = LatLng(33.8869, 9.5375);
  double totalGagne = 0.00;
  String currentLocationName = "Fetching location...";
  GoogleMapController? _mapController;
  bool _isGoButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _locationPermissionGranted = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _locationPermissionGranted = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _locationPermissionGranted = false);
      return;
    }

    setState(() {
      _locationPermissionGranted = true;
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (_currentPosition != null && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          ),
        );
      } else {
        setState(() {
          currentLocationName = "Failed to get location";
        });
      }
    } catch (e) {
      setState(() {
        currentLocationName = "Failed to get location: ${e.toString()}";
      });
    }
  }

  void _onGoButtonPressed() {
    setState(() {
      _isGoButtonPressed = !_isGoButtonPressed;
    });

    if (_isGoButtonPressed) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, "/distance");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: MapScreen()
                    /* MapComponent(
                    initialLocation: _tunisiaLocation,
                    currentPosition: _currentPosition != null
                        ? LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          )
                        : _tunisiaLocation,
                    mapController: (controller) => _mapController = controller,
                  ), */
                    ),
                SizedBox(height: 60),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: ExpandableInfoComponent(totalGagne: totalGagne),
                ),
              ),
            ),
            ActionComponent(
              locationName: currentLocationName,
              isGoButtonPressed: _isGoButtonPressed,
              onGoButtonPressed: _onGoButtonPressed,
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
