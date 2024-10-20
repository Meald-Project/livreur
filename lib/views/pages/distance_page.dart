import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bottombar_distance.dart';
import '../widgets/map_view.dart';
import '../cubit/map_cubit_distance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceCarouselPage extends StatefulWidget {
  @override
  _DistanceCarouselPageState createState() => _DistanceCarouselPageState();
}

class _DistanceCarouselPageState extends State<DistanceCarouselPage> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit([
        {
          'name': 'Your Location',
          'lat': 36.8065, 
          'lng': 10.1815,
          'destination': {
            'name': 'Tunis',
            'lat': 36.8005,
            'lng': 10.1811,
          },
          'duration': '30 minutes',
        },
        {
          'name': 'Tunis',
          'lat': 36.8005,
          'lng': 10.1811,
          'destination': {
            'name': 'Sousse',
            'lat': 35.8260,
            'lng': 10.6361,
          },
          'duration': '1 hour',
        },
      ]),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Order to > Client Name',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Expanded(
              child: MapView(), // Moved to a separate component
            ),
            BottomBar(
              startLocation: 'Your Location',
              endLocation: 'Sousse',
              distance: "150 km",
              shippingFee: "20 TND",
              duration: "30 minutes",
            ),
          ],
        ),
      ),
    );
  }
}
