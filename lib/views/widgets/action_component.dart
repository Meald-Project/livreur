// action_component.dart

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_info.dart';

class ActionComponent extends StatelessWidget {
  final String locationName;
  final bool isGoButtonPressed;
  final VoidCallback onGoButtonPressed;

  const ActionComponent({
    Key? key,
    required this.locationName,
    required this.isGoButtonPressed,
    required this.onGoButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 660,
          bottom: 0,
          left: 0,
          right: 0,
          child: LocationInfoComponent(locationName: locationName),
        ),
        Positioned(
          bottom: 30,
          right: MediaQuery.of(context).size.width * 0.5 - 35,
          child: GestureDetector(
            onTap: onGoButtonPressed,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: isGoButtonPressed ? Colors.green : Colors.black,
              child: const Text(
                "GO",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
