import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController forgottenEmailController =
      TextEditingController();

  @override
  void dispose() {
    forgottenEmailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgottenEmailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset link has been sent!"),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const VerticalSpace(height: 0.1),
          const Text(
            "Enter your email to reset your password.",
            style: TextStyle(fontSize: 15),
          ),
          const VerticalSpace(height: .06),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.email),
              SizedBox(
                width: Responsive.getWidth(context) * .80,
                child: AppTextFormField(
                  controller: forgottenEmailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  hintText: 'Email',
                  validator: (email) {
                    if (email!.isEmpty || !EmailValidator.validate(email)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const VerticalSpace(height: .06),
          SizedBox(
            width: Responsive.getWidth(context) * .85,
            height: Responsive.getHeight(context) * .05,
            child: ElevatedButton(
                onPressed: passwordReset,
                child: AutoSizeText(
                  'Rest Password',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w900),
                )),
          ),
          const VerticalSpace(height: 0.1),
        ],
      ),
    );
  }
}
