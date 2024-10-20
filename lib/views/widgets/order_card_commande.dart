import 'package:flutter/material.dart';
import '../../models/order_commande.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final TextEditingController _clientCodeController = TextEditingController();
  bool _isSubmitted = false; // Track submission state

  void _showClientCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrer le code client'),
          content: TextField(
            controller: _clientCodeController,
            decoration: InputDecoration(hintText: "Code client"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Handle the client code submission here
                String clientCode = _clientCodeController.text;
                print('Client Code: $clientCode'); // You can use this value as needed

                setState(() {
                  widget.order.status = 'Livré'; // Update order status
                  _isSubmitted = true; // Mark as submitted
                });

                _clientCodeController.clear(); // Clear the text field
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Soumettre'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set text color based on submission status
    Color textColor = _isSubmitted ? Colors.grey : Colors.black;
    Color statusColor = widget.order.status == 'Livré' ? Colors.green : Colors.orange;

    return AbsorbPointer(
      absorbing: _isSubmitted, // Disable interaction if submitted
      child: Card(
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurant: ${widget.order.restaurantName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
              ),
              SizedBox(height: 8),
              Text(
                'Date: ${widget.order.date}',
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 16),
              Text(
                'Total de la commande: \$${widget.order.total.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              SizedBox(height: 8),
              Text(
                'Frais de livraison: \$${widget.order.shippingFee.toStringAsFixed(2)}',
                style: TextStyle(color: textColor),
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status: ${widget.order.status}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isSubmitted ? Colors.grey : statusColor,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Livré') {
                        _showClientCodeDialog(); // Show dialog for client code
                      } else {
                        setState(() {
                          widget.order.status = value; // Update the status
                          _isSubmitted = value == 'Livré'; // Mark as submitted if 'Livré'
                        });
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return ['Livré', 'En cours', 'Annulée'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
