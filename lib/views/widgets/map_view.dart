import 'package:flutter/material.dart';
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
