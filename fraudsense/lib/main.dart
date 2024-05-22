import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/theme/theme.dart';
import 'package:fraudsense/firebase_options.dart';
import 'package:fraudsense/screens/welcome_screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const WelcomeScreen(),
    );
  }
}
