import 'package:flutter/material.dart';
import 'app_textfield_create.dart'; // Ensure you import your AppTextField

class FullNameField extends StatelessWidget {
  final bool isSmallScreen;

  const FullNameField({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Votre Nom Complet * :",
          style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
        ),
        const SizedBox(height: 10),
        AppTextField(
          isSmallScreen: isSmallScreen,
          hintText: 'Entrez votre nom complet',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
