import 'package:flutter/material.dart';


class InputFieldComponent extends StatelessWidget {
  final String label;
  final bool isSmallScreen;
  final TextEditingController? controller;

  const InputFieldComponent({super.key, required this.label, required this.isSmallScreen, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: isSmallScreen ? MediaQuery.of(context).size.width * 0.8 : 300,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 245, 250, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
}
