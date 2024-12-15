import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as webservice;
import 'package:location/location.dart' as loc;

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _controller;
  loc.Location _location = loc.Location();
  LatLng? _currentPosition;
  LatLng _destinationPosition = LatLng(36.852756, 10.184494);
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  bool _loading = true;
  bool _isNavigating = false;
  String _distance = "";
  String _duration = "";
  double _remainingDistance = 0.0;

  webservice.GoogleMapsDirections directionsApi =
      webservice.GoogleMapsDirections(
    apiKey:
        'AIzaSyBKDvpAt8Om86kDJtWpknTxglhlEFYv0rA', // Replace with your API key
  );

  @override
  void initState() {
    super.initState();
    _initializeLocationAndRoute();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _location.onLocationChanged.listen((loc.LocationData currentLocation) {
      _updateCurrentPosition(currentLocation);
    });
  }

  void _updateCurrentPosition(loc.LocationData currentLocation) {
    setState(() {
      _currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      // Calculate remaining distance
      _remainingDistance =
          _calculateDistance(_currentPosition!, _destinationPosition);

      // Check if destination is reached
      if (_remainingDistance < 0.1) {
        // Within 100 meters
        _stopNavigation();
      }

      // Update map camera during navigation
      if (_isNavigating && _controller != null) {
        _controller!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _currentPosition!, zoom: 16.0)));
      }
    });
  }

  double _calculateDistance(LatLng start, LatLng end) {
    var p = 0.017453292519943295; // Pi / 180
    var a = 0.5 -
        cos((end.latitude - start.latitude) * p) / 2 +
        cos(start.latitude * p) *
            cos(end.latitude * p) *
            (1 - cos((end.longitude - start.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  Future<void> _initializeLocationAndRoute() async {
    try {
      // Request location permissions
      bool _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) throw Exception("Location services disabled.");
      }

      loc.PermissionStatus _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == loc.PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != loc.PermissionStatus.granted) {
          throw Exception("Location permission denied.");
        }
      }

      // Get current location
      var currentLocation = await _location.getLocation();
      _currentPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      // Draw the route
      await _drawRoute();
    } catch (e) {
      print("Error initializing location or route: $e");
    } finally {
      // End loading state
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _drawRoute() async {
    if (_currentPosition == null) return;

    try {
      // Fetch route from Google Directions API
      webservice.DirectionsResponse response =
          await directionsApi.directionsWithLocation(
        webservice.Location(
            lat: _currentPosition!.latitude, lng: _currentPosition!.longitude),
        webservice.Location(
            lat: _destinationPosition.latitude,
            lng: _destinationPosition.longitude),
        travelMode: webservice.TravelMode.driving,
        alternatives: false,
      );

      if (response.isOkay) {
        polylineCoordinates.clear();

        // Decode the overview polyline for the route
        String overviewPolyline = response.routes.first.overviewPolyline.points;
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> decodedPoints =
            polylinePoints.decodePolyline(overviewPolyline);

        polylineCoordinates.addAll(
          decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
        );

        // Get the distance and duration from the Directions API response
        var leg = response.routes.first.legs.first;
        setState(() {
          _distance = leg.distance?.text ?? "Distance not available";
          _duration = leg.duration?.text ?? "Duration not available";
        });

        // Update polylines
        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ));
        });

        // Adjust camera bounds
        LatLngBounds bounds =
            _getBounds(_currentPosition!, _destinationPosition);
        _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      } else {
        throw Exception("API response error: ${response.errorMessage}");
      }
    } catch (e) {
      print("Error drawing route: $e");
    }
  }

  LatLngBounds _getBounds(LatLng start, LatLng end) {
    return LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );
  }

  void _startNavigation() {
    setState(() {
      _isNavigating = true;
    });
  }

  void _stopNavigation() {
    setState(() {
      _isNavigating = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have reached your destination!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
        actions: [
          if (!_isNavigating)
            IconButton(
              icon: Icon(Icons.navigation),
              onPressed: _startNavigation,
            )
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (_isNavigating) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Remaining Distance: ${_remainingDistance.toStringAsFixed(2)} km",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total Distance: $_distance",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Estimated Duration: $_duration",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _currentPosition!, zoom: 12.0),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    myLocationEnabled: true,
                    polylines: _polylines,
                    markers: {
                      Marker(
                        markerId: MarkerId("origin"),
                        position: _currentPosition!,
                        infoWindow: InfoWindow(title: "Your Location"),
                      ),
                      Marker(
                        markerId: MarkerId("destination"),
                        position: _destinationPosition,
                        infoWindow: InfoWindow(title: "Destination"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                      ),
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
















/* import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as webservice;
import 'package:location/location.dart' as loc;

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _controller;
  loc.Location _location = loc.Location();
  LatLng? _initialPosition;
  LatLng _destinationPosition =
      LatLng(36.852756, 10.184494); // Destination (example location)
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  bool _loading = true;
  String _distance = "";
  String _duration = "";

  webservice.GoogleMapsDirections directionsApi =
      webservice.GoogleMapsDirections(
    apiKey:
        'AIzaSyBKDvpAt8Om86kDJtWpknTxglhlEFYv0rA', // Your Google Maps API key
  );

  @override
  void initState() {
    super.initState();
    _initializeLocationAndRoute();
  }

  Future<void> _initializeLocationAndRoute() async {
    try {
      // Request location permissions
      bool _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) throw Exception("Location services disabled.");
      }

      loc.PermissionStatus _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == loc.PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != loc.PermissionStatus.granted) {
          throw Exception("Location permission denied.");
        }
      }

      // Get current location
      var currentLocation = await _location.getLocation();
      _initialPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      // Draw the route
      await _drawRoute();
    } catch (e) {
      print("Error initializing location or route: $e");
    } finally {
      // End loading state
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _drawRoute() async {
    if (_initialPosition == null) return;

    try {
      print("Fetching route...");
      print("Start: $_initialPosition");
      print("Destination: $_destinationPosition");

      // Fetch route from Google Directions API
      webservice.DirectionsResponse response =
          await directionsApi.directionsWithLocation(
        webservice.Location(
            lat: _initialPosition!.latitude, lng: _initialPosition!.longitude),
        webservice.Location(
            lat: _destinationPosition.latitude,
            lng: _destinationPosition.longitude),
        travelMode: webservice.TravelMode.driving,
        alternatives: false,
      );

      if (response.isOkay) {
        print("Route fetched successfully.");

        polylineCoordinates.clear();

        // Decode the overview polyline for the route
        String overviewPolyline = response.routes.first.overviewPolyline.points;
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> decodedPoints =
            polylinePoints.decodePolyline(overviewPolyline);

        if (decodedPoints.isEmpty) {
          throw Exception("Failed to decode polyline.");
        }

        print("Decoded ${decodedPoints.length} points.");
        polylineCoordinates.addAll(
          decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList(),
        );

        // Get the distance and duration from the Directions API response
        var leg = response.routes.first.legs.first;
        setState(() {
          _distance = leg.distance?.text ?? "Distance not available";
          _duration = leg.duration?.text ?? "Duration not available";
        });

        // Update polylines
        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ));
        });

        // Adjust camera bounds
        LatLngBounds bounds =
            _getBounds(_initialPosition!, _destinationPosition);
        _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      } else {
        throw Exception("API response error: ${response.errorMessage}");
      }
    } catch (e) {
      print("Error drawing route: $e");
    }
  }

  LatLngBounds _getBounds(LatLng start, LatLng end) {
    return LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );
  }

  void _startNavigation() {
    // Optionally, use a navigation app like Google Maps to navigate to the destination
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=${_initialPosition!.latitude},${_initialPosition!.longitude}&destination=${_destinationPosition.latitude},${_destinationPosition.longitude}&travelmode=driving';
    // Open Google Maps navigation in browser or external app
    print("Starting navigation: $googleMapsUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map View"),
        actions: [
          IconButton(
            icon: Icon(Icons.directions),
            onPressed: _startNavigation, // Start navigation
          )
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Distance: $_distance",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Duration: $_duration",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition!, zoom: 12.0),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    myLocationEnabled: true,
                    polylines: _polylines,
                    markers: {
                      Marker(
                        markerId: MarkerId("origin"),
                        position: _initialPosition!,
                        infoWindow: InfoWindow(title: "Your Location"),
                      ),
                      Marker(
                        markerId: MarkerId("destination"),
                        position: _destinationPosition,
                        infoWindow: InfoWindow(title: "Destination"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen), // Change color to green
                      ),
                    },
                  ),
                ),
              ],
            ),
    );
  }
} */





















/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/map_cubit_distance.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        final locations = context.read<MapCubit>().locations;

        return CarouselSlider.builder(
          itemCount: locations.length,
          itemBuilder: (context, index, realIndex) {
            final location = locations[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  context.read<MapCubit>().updateMap(index);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(location['lat'], location['lng']),
                  zoom: 8,
                ),
                markers: state.markers,
                polylines: state.polylines,
              ),
            );
          },
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.7,
            autoPlay: false,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
          ),
        );
      },
    );
  }
}
 */