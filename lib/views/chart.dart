import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  final List<Article> articles = [
    Article(
      nom: 'Sandwich Thon',
      price: 10.00,
      quantity: 2,
      imageUrl: 'https://assets.afcdn.com/recipe/20160928/21224_w1024h1024c1cx2128cy1416.webp',
      description: 'plus de fromage et sans onions',
    ),
    Article(
      nom: 'Pack Kids',
      price: 15.00,
      quantity: 1,
      imageUrl: 'https://c8.alamy.com/compfr/2j0c1cj/doubleburger-double-hamburger-menu-avec-frites-assiette-sans-boisson-2j0c1cj.jpg',
      description: 'Hamburger + Frites + Boisson Viva',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice = articles.fold(0, (sum, article) => sum + article.price * article.quantity);
    double shippingPrice = 10.0;
    double orderPrice = totalPrice + shippingPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Panier'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ChartItem(article: articles[index]);
        },
      ),
      bottomNavigationBar: Container(
 decoration: BoxDecoration(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    color: Colors.white,
    border: Border.all(color: Colors.grey[300]!),
  ),
  padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adresse de livraison',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700]
              ),
            ),
            SizedBox(height: 8),
           Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Use a shade of grey for background
        borderRadius: BorderRadius.circular(5.0), // Optional: Rounded corners
        border: Border.all(color: Colors.grey[300]!), // Optional: Border color
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0), // Optional: Padding
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Default Address', // Placeholder text
          border: InputBorder.none, // Remove default border
        ),
      ),
    ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prix de l'ordre",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[700]),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)} Dt',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prix livraison',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                Text(
                  '${shippingPrice.toStringAsFixed(2)} Dt',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Divider(height: 20, color: Colors.grey),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  '${orderPrice.toStringAsFixed(2)} Dt',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Checkout page
              },
              child: Text('Achetez', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String nom;
  final double price;
  final int quantity;
  final String imageUrl;
  final String description;

  Article({
    required this.nom,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrl,
  });
}

class ChartItem extends StatelessWidget {
  final Article article;

  const ChartItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifierChartArticle(article: article),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 0), // Added left padding here
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(article.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.nom,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _truncateDescription(article.description),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(article.price.toStringAsFixed(2)),
                              SizedBox(width: 10),
                              Text('Qté: ${article.quantity}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        Positioned(
  top: 5,
  right: 5,
  child: PopupMenuButton<String>(
    onSelected: (value) {
      if (value == 'update') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifierChartArticle(article: article),
          ),
        );
      } else if (value == 'delete') {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Implement delete logic here
                  // After deletion, navigate back to chart page or update state
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'update',
        child: ListTile(
          leading: Icon(Icons.edit),
          title: Text('Update'),
        ),
      ),
      const PopupMenuItem<String>(
        value: 'delete',
        child: ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
        ),
      ),
    ],
    icon: Icon(Icons.more_vert),
  ),
),  ],
          ),
        ),
      ),
    );
  }

  String _truncateDescription(String description) {
    if (description.length <= 20) {
      return description;
    } else {
      return description.substring(0, 20) + '...';
    }
  }
}

class ModifierChartArticle extends StatelessWidget {
  final Article article;

  const ModifierChartArticle({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Article Nom: ${article.nom}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Prix: ${article.price}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Quantité: ${article.quantity}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
