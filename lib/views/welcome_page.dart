import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/themes/theme_provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4590), () {
      Navigator.pushReplacement(
        context,
        _createRoute(FirstPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          '../assets/LOGO.png',
          height: 130,
          width: 130,
        ),
      ),
    );
  }
}


// class ThemeSelectionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose Theme',
//          style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.italic,
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<ThemeProvider>(context, listen: false).setLightMode();
//                 Navigator.push(context,_createRoute(FirstPage()));

//               },
//               style: ElevatedButton.styleFrom( 
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//               child: Text(
//                 'Light Mode',
//                 style: TextStyle(fontSize: 18 , color: Colors.orange),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<ThemeProvider>(context, listen: false).setDarkMode();
//                 Navigator.push(context,_createRoute(FirstPage()));
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(
//                     color: Colors.orange,
//                   ),
//                 ),
                
//               ),
//               child: Text(
//                 'Dark Mode',
//                 style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.secondary,),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenue Cher Utilisateur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  '../assets/User.gif',
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCarouselIndicator(active: true),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Text
            Text(
              'Commandez vos plats préférés\n'
              'directement depuis votre téléphone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.tertiary,
                 
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // NEXT button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      _createRoute(SecondPage()),
                    );
                  },
                  child: Text('NEXT =>'),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),

            TextButton(
              onPressed: () {
              Navigator.of(context).pushNamed('/Signup');
              },
              child: Text(
                'Skip this page',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselIndicator({required bool active}) {
    return Container(
      width: active ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.green : Colors.grey,
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Bienvenue Cher Utilisateur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.network(
                    '../assets/Location.gif',
                    width: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: true),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
        
            // Text
            Text(
              'Commandez vos plats préférés\n'
              'directement depuis votre téléphone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.tertiary,

              ),
            ),
            SizedBox(height: 20),
            Container(
                  margin: EdgeInsets.only(bottom: 20,left: 20 ,right: 20),
            // Buttons
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BACK button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('<= BACK'),
                ),
                // NEXT button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      _createRoute(ThirdPage()),
                    );
                  },
                  child: Text('NEXT =>'),
                ),
              ],
            ),
            ),
            SizedBox(height: 10),

            TextButton(
              onPressed: () {
              Navigator.of(context).pushNamed('/Signup');
              },
              child: Text(
                'Skip this page',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselIndicator({required bool active}) {
    return Container(
      width: active ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.green : Colors.grey,
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Bienvenue Cher Utilisateur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.network(
                    '../assets/Driver.gif',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: false),
                      SizedBox(width: 8),
                      _buildCarouselIndicator(active: true),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Text
            Text(
              'Commandez vos plats préférés\n'
              'directement depuis votre téléphone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.tertiary,
 
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Container(
                  margin: EdgeInsets.only(bottom: 22,left: 20 ,right: 20),
            // Buttons
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BACK button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('<= BACK'),
                ),
                // NEXT button
                ElevatedButton(
                  onPressed: () {
              Navigator.of(context).pushNamed('/Signup');
                  },
                  child: Text('NEXT =>'),
                ),
              ],
            ),
            ),
             SizedBox(height: 10),
            TextButton(
              onPressed: () {
              Navigator.of(context).pushNamed('/Signup');
              },
              child: Text(
                'Skip this page',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselIndicator({required bool active}) {
    return Container(
      width: active ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.green : Colors.grey,
      ),
    );
  }
}

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  int selectedButtonIndex = -1;
  String? role;

  @override
  Widget build(BuildContext context) {
    // Get the role passed from Signup, if available
    role = ModalRoute.of(context)!.settings.arguments as String?;

    void _navigateToDestination() {
      if (selectedButtonIndex == -1 && role == null) {
        // Handle the case where no button is selected and no role is passed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a role to proceed.')),
        );
        return;
      }

      if (role == null) {
        // Determine the role based on the selected button
        switch (selectedButtonIndex) {
          case 0:
            role = 'restaurant';
            break;
          case 1:
            role = 'client';
            break;
          case 2:
            role = 'livreur';
            break;
        }
      }

      // Navigate to the appropriate home page based on the selected role
      switch (role) {
        case 'client':
          Navigator.pushNamed(context, '/homePage_client');
          break;
        case 'livreur':
          Navigator.pushNamed(context, '/homePage_livreur');
          break;
        case 'restaurant':
        default:
          Navigator.pushNamed(context, '/homePage_restaurant');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Etes-vous?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleButton('Restaurant', 0),
            _buildRoleButton('Client', 1),
            _buildRoleButton('Livreur', 2),
            SizedBox(height: 20),
            TextButton(
              onPressed: _navigateToDestination,
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(String label, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
            role = null; // Clear any passed role when a button is pressed
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedButtonIndex == index
              ? Colors.green
              : Theme.of(context).colorScheme.onError,
          minimumSize: Size(300, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedButtonIndex == index ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }
}
Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
