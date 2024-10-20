import 'package:flutter/material.dart';
import 'app_textfield_create.dart';

class CinInfoRow extends StatelessWidget {
  final bool isSmallScreen;

  const CinInfoRow({super.key, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double inputWidth = isSmallScreen ? screenWidth * 0.35 : 150.0;  

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Num CIN * :",
              style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: inputWidth,
              child: AppTextField(isSmallScreen: isSmallScreen, hintText: 'Num CIN'),
            ),
          ],
        ),
        SizedBox(width: 50),
        Column(
          children: [
            Text(
              "Date CIN * :",
              style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: inputWidth,
              child: AppTextField(isSmallScreen: isSmallScreen, hintText: 'Date CIN'),
            ),
          ],
        ),
      ],
    );
  }
}
