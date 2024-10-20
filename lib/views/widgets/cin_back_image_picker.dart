import 'package:flutter/material.dart';
import 'image_picker.dart'; // Import your ImagePickerContainer here

class CinBackImagePicker extends StatelessWidget {
  final bool isSmallScreen;
  final VoidCallback onTap;
  final String? imagePath;

  const CinBackImagePicker({
    Key? key,
    required this.isSmallScreen,
    required this.onTap,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Carte Cin Verso * :",
          style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
        ),
        const SizedBox(height: 20),
        ImagePickerContainer(
          isSmallScreen: isSmallScreen,
          onTap: onTap,
          imagePath: imagePath,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
