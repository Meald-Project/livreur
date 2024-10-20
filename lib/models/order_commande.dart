class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final String id;
  final String date;
  final String restaurantName;
  String status; // Change this to allow modification
  final List<OrderItem> items;
  final double total;
  final double shippingFee;

  Order({
    required this.id,
    required this.date,
    required this.restaurantName,
    required this.status,
    required this.items,
    required this.total,
    required this.shippingFee,
  });
}
