import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  loc.Location _location = loc.Location();
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      // Request location permissions if not already granted
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return; // If service is not enabled, exit the function
        }
      }

      loc.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return; // If permission is not granted, exit the function
        }
      }

      // Fetch the current location
      var currentLocation = await _location.getLocation();
      setState(() {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });

      // Move the camera to the current position
      _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator()) // Loading state
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _getUserLocation(); // Fetch location when map is created
              },
              myLocationEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId("current"),
                  position: _currentPosition!,
                  infoWindow: InfoWindow(title: "You are here"),
                ),
              },
            ),
    );
  }
}
































/* import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // Add this import for polyline decoding
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as webservice;
import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  loc.Location _location = loc.Location(); // Use location for current location
  LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Starting Point (San Francisco)
  LatLng _destinationPosition =
      LatLng(34.0522, -118.2437); // Destination (Los Angeles)
  Set<Polyline> _polylines = {}; // Polyline for the route
  List<LatLng> polylineCoordinates = [];

  webservice.GoogleMapsDirections directionsApi =
      webservice.GoogleMapsDirections(
          apiKey: 'AIzaSyBKDvpAt8Om86kDJtWpknTxglhlEFYv0rA');

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _drawRoute(); // Fetch route and draw it
  }

  Future<void> _getUserLocation() async {
    var currentLocation = await _location.getLocation();
    setState(() {
      _initialPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  Future<void> _drawRoute() async {
    webservice.DirectionsResponse response =
        await directionsApi.directionsWithLocation(
      webservice.Location(
          lat: _initialPosition.latitude,
          lng: _initialPosition.longitude), // Start
      webservice.Location(
          lat: _destinationPosition.latitude,
          lng: _destinationPosition.longitude), // End
      travelMode: webservice.TravelMode.driving, // Specify driving mode
      alternatives: false, // Use only the main route
    );

    if (response.isOkay) {
      // Clear any existing polylines
      polylineCoordinates.clear();

      // Loop through each leg and step in the route
      for (var leg in response.routes.first.legs) {
        for (var step in leg.steps) {
          // Decode the polyline for each step and add to polylineCoordinates
          PolylinePoints polylinePoints = PolylinePoints();
          List<PointLatLng> result =
              polylinePoints.decodePolyline(step.polyline.points);

          polylineCoordinates.addAll(
            result
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList(),
          );
        }
      }

      // Add the polyline to the map
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    } else {
      print('Error: ${response.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Itinerary")),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 12.0),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        myLocationEnabled: true,
        polylines: _polylines, // Use the Polyline set
        markers: {
          Marker(
            markerId: MarkerId("origin"),
            position: _initialPosition,
            infoWindow: InfoWindow(title: "Start Location"),
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: _destinationPosition,
            infoWindow: InfoWindow(title: "Destination"),
          ),
        },
      ),
    );
  }
}
 */