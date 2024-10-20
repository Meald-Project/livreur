import 'package:flutter/material.dart';

class LocationInfoComponent extends StatelessWidget {
  final String locationName;

  const LocationInfoComponent({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Localisation actuelle',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            locationName,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
