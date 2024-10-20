import 'package:flutter/material.dart';
import '../pages/mes_commandes_drawer.dart';
class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('/profile.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Nom du Livreur',
                  style: TextStyle(color:Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.black),
            title: Text('Mes Commandes', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushNamed(context, '/commandes'); // Navigate to Mes Commandes
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.black),
            title: Text('Notifications', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushNamed(context, '/notifications'); // Navigate to Notifications
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Settings', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pushNamed(context, '/settings'); // Navigate to Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red), // Red icon for logout
            title: Text('Logout', style: TextStyle(color: Colors.red)), // Red text for logout
            onTap: () {
              Navigator.pushNamed(context, '/logout'); // Navigate to Logout
            },
          ),
        ],
      ),
    );
  }
}
