import 'package:flutter/material.dart';
import 'app_textfield_create.dart'; // Ensure you import your AppTextField

class BirthDateField extends StatelessWidget {
  final bool isSmallScreen;

  const BirthDateField({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date De naissance :",
          style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
        ),
        const SizedBox(height: 10),
        AppTextField(
          isSmallScreen: isSmallScreen,
          hintText: 'Entrez votre date de naissance',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
