import 'package:flutter/material.dart';
import 'footer.dart';
import 'parametres_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'commande_details_page.dart'; 

class CommandesPage extends StatefulWidget {
  @override
  _CommandesPageState createState() => _CommandesPageState();
}

class _CommandesPageState extends State<CommandesPage> {
  int _selectedIndex = 1; // Index de la page courante
  int? draggedIndex; // Track the dragged item
  bool isDraggingOverTrash = false; // Track if over trash

  List<String> commandes = List.generate(8, (index) => 'Commande #${index + 1}'); 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilPage()),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ParametresPage()),
        );
      }
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette commande?'),
          actions: <Widget>[
            TextButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without deleting
              },
            ),
            TextButton(
              child: Text('Oui'),
              onPressed: () {
                setState(() {
                  commandes.removeAt(index); // Remove the item
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes à Livrer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/HomePage_livreur', (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Logique pour actualiser la liste des commandes
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: commandes.length,
              itemBuilder: (context, index) {
                return Draggable<int>(
                  data: index,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: _buildCommandCard(index),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: _buildCommandCard(index, isDragging: true),
                  ),
                  child: _buildCommandCard(index),
                );
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: DragTarget<int>(
              onAccept: (index) {
                setState(() {
                  isDraggingOverTrash = false;
                });
                _showDeleteConfirmationDialog(context, index);
              },
              onWillAccept: (index) {
                setState(() {
                  isDraggingOverTrash = true;
                });
                return true;
              },
              onLeave: (index) {
                setState(() {
                  isDraggingOverTrash = false;
                });
              },
              builder: (context, candidateData, rejectedData) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isDraggingOverTrash ? Colors.redAccent : Colors.grey[200],
                    shape: BoxShape.circle,
                    boxShadow: isDraggingOverTrash
                        ? [BoxShadow(color: Colors.red, blurRadius: 10, spreadRadius: 5)]
                        : [BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2)],
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 30,
                    color: isDraggingOverTrash ? Colors.white : Colors.grey[700],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: FooterWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // Method to build each command card
  Widget _buildCommandCard(int index, {bool isDragging = false}) {
    return Card(
      elevation: isDragging ? 2 : 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(commandes[index]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: Client ${index + 1}'),
            Text('Adresse: 456 Avenue Example'),
            Text('Téléphone: 0123456789'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, color: Colors.green),
            SizedBox(height: 4),
            Text('En attente', style: TextStyle(color: Colors.green)),
          ],
        ),
        onTap: () {
          // Logique pour afficher les détails de la commande
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommandeDetailsPage(),
            ),
          );
        },
      ),
    );
  }
}
