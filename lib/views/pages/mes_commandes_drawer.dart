import 'package:flutter/material.dart';
import '../../models/order_commande.dart';
import '../widgets/order_card_commande.dart';
import '../widgets/search_bar.dart';

class CommandePage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: '12345',
      date: '2024-08-25',
      restaurantName: 'Le Gourmet',
      status: 'En cours',
      items: [
        OrderItem(name: 'Caesar Salad', quantity: 1, price: 8.00),
        OrderItem(name: 'Sandwich Thon', quantity: 2, price: 12.00),
      ],
      total: 32.00,
      shippingFee: 5.00,
    ),
    Order(
      id: '67890',
      date: '2024-08-24',
      restaurantName: 'Chez Tony',
      status: 'En cours',
      items: [
        OrderItem(name: 'Sandwich Thon', quantity: 1, price: 10.00),
        OrderItem(name: 'Pack Kids', quantity: 2, price: 15.00),
      ],
      total: 40.00,
      shippingFee: 4.50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Commandes'),
      ),
      body: Column(
        children: [
          SearchBarComponent(),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/distance", arguments: order);
                  },
                  child: OrderCard(order: order),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
