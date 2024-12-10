import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/authentication%20screens/auth_screen.dart';
import 'package:fraudsense/screens/home_screen.dart';

//screen responsible for switching between the authentication screen
//and the home screen depending if the user is logged in or not.

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = ref.watch(firebaseAuthProvider);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
