import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'login_screen.dart';
import 'user_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      // initialRoute: '/A',
      home: AnimatedSplashScreen(
        splashIconSize: 150,
        splash: 'assets/blslogo.png',
        nextScreen: const UserDashboard(),
        splashTransition: SplashTransition.rotationTransition,
      ),

      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        UserDashboard.routeName: (context) => const UserDashboard(),
      },
    );
  }
}
