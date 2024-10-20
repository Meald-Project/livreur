import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return SizedBox(
      width: isSmallScreen ? screenWidth * 0.8 : 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/homePage_livreur');
          print('Saved!');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.green, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 25),
        ),
        child: Text(
          "Sauvegarder",
          style: TextStyle(fontSize: isSmallScreen ? 16 : 18, color: Colors.white),
        ),
      ),
    );
  }
}
