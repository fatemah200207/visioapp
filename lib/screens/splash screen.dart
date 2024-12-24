import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:visioapp/screens/home%20screen.dart';
import 'package:visioapp/screens/login screen.dart';
import 'package:visioapp/screens/sign up screen.dart'; // Import the Signup screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3), () {
      bool isUserLoggedIn = false; // This should be replaced with actual login status check logic.

      if (isUserLoggedIn) {
        // Navigate to the Home Screen if the user is logged in
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomeScreen(),  // Remove const here
          ),
        );
      } else {
        // Navigate to the Login Screen if the user is not logged in
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),  // Remove const here
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB2EBF2), Color(0xFFFFCDD2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),


          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.motion_photos_on_outlined,
                size: 150,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'VISIO',
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}