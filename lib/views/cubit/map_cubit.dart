import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final LatLngBounds? bounds;
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  MapState({
    this.bounds,
    required this.markers,
    required this.polylines,
  });
}

class MapCubit extends Cubit<MapState> {
  final List<Map<String, dynamic>> locations;

  MapCubit(this.locations)
      : super(MapState(
          bounds: null,
          markers: {},
          polylines: {},
        ));

  void updateMap(int index) {
    final location = locations[index];
    LatLng start = LatLng(location['lat'], location['lng']);
    LatLng end = LatLng(location['destination']['lat'], location['destination']['lng']);

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );

    Set<Marker> markers = {
      Marker(
        markerId: MarkerId(location['name']),
        position: start,
      ),
      Marker(
        markerId: MarkerId(location['destination']['name']),
        position: end,
      ),
    };

    Set<Polyline> polylines = {
      Polyline(
        polylineId: PolylineId('route_$index'),
        points: [start, end],
        color: Colors.blue,
        width: 5,
      ),
    };

    emit(MapState(bounds: bounds, markers: markers, polylines: polylines));
  }
}
