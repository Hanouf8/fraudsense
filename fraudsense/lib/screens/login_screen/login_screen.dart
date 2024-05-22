import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/forgot_pw_screen.dart';
import 'package:fraudsense/screens/signup_screen/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  Future LogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmailController.text.trim(),
          password: loginPasswordController.text.trim());
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

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/login_image.jpeg',
                height: Responsive.getHeight(context) * .30,
                fit: BoxFit.cover,
              ),
              const VerticalSpace(height: .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.email),
                  SizedBox(
                    width: Responsive.getWidth(context) * .80,
                    child: AppTextFormField(
                      controller: loginEmailController,
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
              const VerticalSpace(height: .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.lock),
                  SizedBox(
                    width: Responsive.getWidth(context) * .80,
                    child: AppTextFormField(
                      controller: loginPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      maxLines: 1,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      obscureText: isVisible ? true : false,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'please enter a password';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const VerticalSpace(height: .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordScreen();
                        }));
                      },
                      child: const AutoSizeText(
                        'Forgot your password?',
                        maxLines: 1,
                      )),
                ],
              ),
              const VerticalSpace(height: .02),
              SizedBox(
                width: Responsive.getWidth(context) * .85,
                height: Responsive.getHeight(context) * .05,
                child: ElevatedButton(
                    onPressed: () {
                      if (loginFormKey.currentState!.validate()) LogIn();
                    },
                    child: AutoSizeText(
                      'Sign in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                    )),
              ),
              const VerticalSpace(height: .05),
              SizedBox(
                width: Responsive.getWidth(context) * .90,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    AutoSizeText(
                      'Create',
                      maxLines: 1,
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpace(height: .06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AutoSizeText(
                    'Dont have an account?',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                      onPressed: widget.showRegisterPage,
                      child: const AutoSizeText(
                        'Sign Up',
                        maxLines: 1,
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}
