import 'package:flutter/material.dart';

class RegionDropdown extends StatelessWidget {
  final bool isSmallScreen;

  const RegionDropdown({Key? key, required this.isSmallScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Votre Region * :",
          style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          isExpanded: true,
          items: [
            DropdownMenuItem(value: 'Region1', child: Text('Region 1')),
            DropdownMenuItem(value: 'Region2', child: Text('Region 2')),
          ],
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Sélectionnez votre région',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
