import 'package:flutter/material.dart';
import 'package:meald/viewmodels/user_view_model.dart';
import 'package:meald/views/login.dart';
import 'views/livreur/home_page.dart';
import 'views/welcome_page.dart';
import 'views/signup.dart';
import 'package:meald/viewmodels/footer_view_model.dart'; 
import 'package:provider/provider.dart';
import '../widgets/themes/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<FooterViewModel>(
          create: (_) => FooterViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
            '/Signup': (context) => Signup(),
            '/Login': (context) => Login(),
            '/HomePage_livreur': (context) => HomePage(),
          },
        );
      },
    );
  }
}
