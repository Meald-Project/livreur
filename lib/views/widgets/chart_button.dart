import 'package:flutter/material.dart';

class ChartButton extends StatelessWidget {
  final String timeFrame;
  final VoidCallback onPressed;

  ChartButton({required this.timeFrame, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(timeFrame),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 225, 225, 225),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
