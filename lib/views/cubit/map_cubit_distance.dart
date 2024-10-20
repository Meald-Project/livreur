import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapState {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final LatLngBounds? bounds;

  MapState({
    required this.markers,
    required this.polylines,
    this.bounds,
  });
}

class MapCubit extends Cubit<MapState> {
  final List<Map<String, dynamic>> locations;

  MapCubit(this.locations) : super(MapState(markers: {}, polylines: {}));

  void updateMap(int index) {
    final location = locations[index];
    final destination = location['destination'];

    final markers = <Marker>{
      Marker(
        markerId: MarkerId('start'),
        position: LatLng(location['lat'], location['lng']),
        infoWindow: InfoWindow(title: location['name']),
      ),
      Marker(
        markerId: MarkerId('end'),
        position: LatLng(destination['lat'], destination['lng']),
        infoWindow: InfoWindow(title: destination['name']),
      ),
    };

    final polylines = <Polyline>{
      Polyline(
        polylineId: PolylineId('route'),
        points: [
          LatLng(location['lat'], location['lng']),
          LatLng(destination['lat'], destination['lng']),
        ],
        color: Colors.blue,
        width: 5,
      ),
    };

    final bounds = LatLngBounds(
      southwest: LatLng(destination['lat'], destination['lng']),
      northeast: LatLng(location['lat'], location['lng']),
    );

    emit(MapState(markers: markers, polylines: polylines, bounds: bounds));
  }
}
