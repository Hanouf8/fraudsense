import 'package:flutter/material.dart';
import 'package:fraudsense/screens/login_screen/login_screen.dart';
import 'package:fraudsense/screens/signup_screen/screen/signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
      print("object");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        showRegisterPage: toggleScreens,
      );
    } else {
      return SignupScreen(
        showLoginPage: toggleScreens,
      );
    }
  }
}
