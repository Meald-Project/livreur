import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final bool isSmallScreen;

  const Header({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Créer Votre Compte",
          style: TextStyle(
            fontSize: isSmallScreen ? 20 : 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
