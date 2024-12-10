import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/sign_out_pop_up.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Icon(
          Icons.reset_tv_rounded,
          color: Colors.red.shade300,
        ),
        onPressed: () {
          signOutPopUp(context: context);
        });
  }
}
