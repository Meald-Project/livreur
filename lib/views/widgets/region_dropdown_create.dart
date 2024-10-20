import 'package:flutter/material.dart';

class RegionDropdown extends StatefulWidget {
  final bool isSmallScreen;

  const RegionDropdown({super.key, required this.isSmallScreen});

  @override
  _RegionDropdownState createState() => _RegionDropdownState();
}

class _RegionDropdownState extends State<RegionDropdown> {
  String? _selectedRegion;
  final List<String> _regions = ["Ariana", "Béja", "Ben Arous", "Bizerte", "Gabès", "Gafsa", "Jendouba", "Kairouan", "Kasserine", "Kebili", "La Manouba", "Le Kef", "Mahdia", "Médenine", "Monastir", "Nabeul", "Sfax", "Sidi Bouzid", "Siliana", "Sousse", "Tataouine", "Tozeur", "Tunis", "Zaghouan"];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: widget.isSmallScreen ? screenWidth * 0.8 : 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 245, 250, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: DropdownButton<String>(
          value: _selectedRegion,
          hint: Text("select your region"),
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          underline: SizedBox(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRegion = newValue!;
            });
          },
          items: _regions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
