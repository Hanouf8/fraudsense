import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/network/internet_connection.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/signup_screen/cubit/firebase_cubit.dart';
import 'package:fraudsense/screens/signup_screen/model/user_model.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignupScreen({super.key, required this.showLoginPage});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisible = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController surnameController = TextEditingController();

  Future signUp() async {
    if (validatePassword(signupPasswordController.text.trim()) == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                  "weak password. Must be at least 8 characters in length and contains one upper case and one lower case."),
            );
          });

      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: signupEmailController.text.trim(),
          password: signupPasswordController.text.trim());
      widget.showLoginPage();
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

  final InternetConnection internetConnection = InternetConnection();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createUserInDatabase({
    required String userName,
    required String email,
    required String surname,
  }) async {
    if (await internetConnection.isInternetConnected) {
      try {
        UserModel userModel = UserModel(
          userName: userName,
          email: email,
          surName: surname,
        );

        firebaseFirestore.collection('users').doc().set(userModel.toJson());
      } catch (error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(error.toString()),
              );
            });
      }
    }
  }

  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');
    if (value.isEmpty) {
      return null;
    } else {
      if (!regex.hasMatch(value)) {
        return null;
      }
    }

    return "1";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FirebaseCubit(),
      child: Scaffold(
        appBar: AppBar(
            // leading: const GetBackButton(),
            ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AutoSizeText(
                  'Sign Up',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: const Color.fromARGB(206, 203, 240, 179),
                      fontWeight: FontWeight.w800),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                const VerticalSpace(height: .01),
                AutoSizeText(
                  'Join Fraudsense to start learning now',
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(height: .03),
                    const AutoSizeText(
                      'Your surname',
                    ),
                    const VerticalSpace(height: .01),
                    AppTextFormField(
                      controller: surnameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Your surname',
                      fillColor: const Color.fromARGB(255, 211, 210, 210),
                      suffixIcon: const Icon(Icons.text_fields),
                      validator: (surname) {
                        if (surname!.isEmpty) {
                          return 'please enter a surname';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpace(height: .01),
                    const AutoSizeText('Your Email'),
                    const VerticalSpace(height: .01),
                    AppTextFormField(
                      controller: signupEmailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Your Email Address',
                      fillColor: const Color.fromARGB(255, 211, 210, 210),
                      suffixIcon: const Icon(Icons.email),
                      validator: (email) {
                        if (email!.isEmpty || !EmailValidator.validate(email)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpace(height: .01),
                    const AutoSizeText('Username'),
                    const VerticalSpace(height: .01),
                    AppTextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Your Username',
                      fillColor: const Color.fromARGB(255, 211, 210, 210),
                      suffixIcon: const Icon(Icons.person),
                      validator: (username) {
                        if (username!.isEmpty) {
                          return 'please enter a username';
                        }
                        return null;
                      },
                    ),
                    const VerticalSpace(height: .01),
                    const AutoSizeText('Choose a secure password'),
                    const VerticalSpace(height: .01),
                    AppTextFormField(
                      controller: signupPasswordController,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      hintText: 'Your password',
                      fillColor: const Color.fromARGB(255, 211, 210, 210),
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
                    const VerticalSpace(height: .01),
                    const AutoSizeText('Confirm your password'),
                    const VerticalSpace(height: .01),
                    AppTextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      hintText: 'Confirm your password',
                      fillColor: const Color.fromARGB(255, 211, 210, 210),
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
                        } else if (signupPasswordController.text !=
                            confirmPasswordController.text) {
                          return 'password does not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const VerticalSpace(height: .05),
                SizedBox(
                    width: Responsive.getWidth(context) * .95,
                    height: Responsive.getHeight(context) * .05,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUp();

                            createUserInDatabase(
                                userName: usernameController.text,
                                email: signupEmailController.text,
                                surname: surnameController.text);
                          }
                          ;
                        },
                        child: AutoSizeText(
                          'Get Started',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w900),
                        ))),
                const VerticalSpace(height: .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AutoSizeText(
                      'Already a member?',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                        onPressed: () {
                          widget.showLoginPage();
                        },
                        child: const AutoSizeText(
                          'Login',
                          maxLines: 1,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    surnameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
