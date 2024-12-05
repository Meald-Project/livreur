import 'package:flutter/material.dart';
import 'package:meald/views/pages/mes_commandes_drawer.dart';

import 'views/login.dart';
import 'views/pages/charts_page.dart';
import 'views/pages/creation_de_Livreur.dart';
import 'views/pages/dashboard.dart';
import 'views/pages/distance_page.dart';
import 'views/pages/livraison_page.dart';
import 'views/pages/settings.dart';
import 'views/signup.dart';
import 'views/welcome_page.dart';
import 'views/widgets/notifications_drawer.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'meald',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/homePage_livreur': (context) => TableauDebord(),
        '/creation_livreur': (context) => CreationDeLivreur(),
        '/Signup': (context) => Signup(),
        '/Login': (context) => Login(),
        '/ChartsPage': (context) => ChartPage(),
        '/commandes': (context) => CommandePage(),
        '/notifications': (context) => Notifications(),
        '/settings': (context) => ParametresPage(),
        '/distance': (context) => DistanceCarouselPage(),
      },
    );
  }
}
