import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/authentication%20screens/login_screen.dart';
import 'package:fraudsense/screens/authentication%20screens/signup_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showLoginPage = ref.watch(loginSignUpToggleProvider);

    return SafeArea(child: showLoginPage ? const LoginScreen() : const SignUpScreen());
  }
}
