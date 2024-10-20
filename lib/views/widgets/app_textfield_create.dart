import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final bool isSmallScreen;
  final String hintText;

  const AppTextField({super.key, required this.isSmallScreen, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: isSmallScreen ? screenWidth * 0.8 : 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 245, 250, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
      ),
    );
  }
}
