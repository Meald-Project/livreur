import 'package:flutter/material.dart';
import 'package:meald/views/pages/mes_commandes_drawer.dart';
import 'package:provider/provider.dart'; 
import 'views/pages/home_page.dart';
import 'views/welcome_page.dart';
import 'views/signup.dart';
import 'views/login.dart';
import 'views/widgets/charts_page.dart';
import 'widgets/themes/theme_provider.dart'; 
import 'views/widgets/notifications_drawer.dart';
import 'views/pages/settings.dart';
import 'views/pages/creation_de_Livreur.dart'; 
import 'views/pages/distance_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'meald',
          theme: themeProvider.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => WelcomePage(),
            '/homePage_livreur': (context) => LivraisonPage(), 
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
      },
    );
  }
}
