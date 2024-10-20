import 'package:flutter/material.dart';

class SearchBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button
            },
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 214, 214, 214),
          hintText: 'Recherchez Des Plats Où Des Restaurants..',
          hintStyle: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
