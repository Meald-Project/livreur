import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 

class ImagePickerContainer extends StatelessWidget {
  final bool isSmallScreen;
  final String? imagePath; 
  final VoidCallback onTap; 

  const ImagePickerContainer({
    super.key,
    required this.isSmallScreen,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSmallScreen ? 100 : 150,
        height: isSmallScreen ? 100 : 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          image: imagePath != null
              ? (kIsWeb 
                  ? DecorationImage(
                      image: NetworkImage(imagePath!), 
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: FileImage(File(imagePath!)), 
                      fit: BoxFit.cover,
                    ))
              : null,
        ),
        child: imagePath == null
            ? Center(child: Image.network("https://www.shutterstock.com/image-vector/rotate-camera-vector-icon-filled-600nw-1113118634.jpg"))  
            : null,
      ),
    );
  }
}
