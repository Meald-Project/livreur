import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String distance;
  final String shippingFee;
  final String duration;

  const BottomBar({
    Key? key,
    required this.startLocation,
    required this.endLocation,
    required this.distance,
    required this.shippingFee,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startLocation,
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              Text(
                endLocation,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            distance,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            duration,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            shippingFee,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
