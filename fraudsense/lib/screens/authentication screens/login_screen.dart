import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/core/components/simple_pop_up.dart';
import 'package:fraudsense/core/language/language_manager.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/authentication%20screens/rest_password_screen.dart';
import 'package:fraudsense/screens/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onLoginClick(WidgetRef ref) async {
      CloudController cloudController = ref.watch(cloudControllerProvider);

      ref.read(homeTabIndexProvider.notifier).state = 0;
      FocusManager.instance.primaryFocus?.unfocus();
      SoundManager.instance.playSound("tab");

      if (loginFormKey.currentState!.validate()) {
        Result loginResult = await cloudController.logIn(
            email: loginEmailController.text.trim(), password: loginPasswordController.text.trim());

        if (!loginResult.isSuccess) {
          String message = LanguageManager.localizeFirebaseExceptionError(
              context: context, errorCode: loginResult.error!);

          simplePopUp(message: message, context: context, ref: ref);
        }
      }
    }

    return Consumer(
      builder: (context, ref, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: Scaffold(
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
                              key: const Key('emailField'),
                              controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 1,
                              // key: loginEmailFieldKey,
                              hintText: S.of(context).loginScreen_emailField,
                              validator: (email) {
                                if (email!.isEmpty || !EmailValidator.validate(email)) {
                                  simplePopUp(
                                      message: S.of(context).signUpScreen_enterEmailPopUp,
                                      context: context,
                                      ref: ref);
                                  return S.of(context).signUpScreen_enterEmailPopUp;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpace(height: .02),

                      //entering password
                      //using consumer to watch and read for the password visibility provider
                      Consumer(
                        builder: (context, ref, child) {
                          final bool isPasswordVisible = ref.watch(passwordVisibilityProvider);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.lock),
                              SizedBox(
                                width: Responsive.getWidth(context) * .80,
                                child: AppTextFormField(
                                  key: const Key('passwordField'),

                                  controller: loginPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: S.of(context).loginScreen_passwordField,
                                  // key: passwordFieldKey,
                                  maxLines: 1,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        ref.read(passwordVisibilityProvider.notifier).toggle();
                                      },
                                      icon: isPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  obscureText: !isPasswordVisible ? true : false,
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      simplePopUp(
                                          message: S.of(context).signUpScreen_enterPasswordPopUp,
                                          context: context,
                                          ref: ref);

                                      return S.of(context).signUpScreen_enterPasswordPopUp;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const VerticalSpace(height: .02),
                      //forgot password button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: AutoSizeText(
                              S.of(context).loginScreen_forgotPasswordText,
                              maxLines: 1,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ResetPasswordScreen();
                              }));
                            },
                          ),
                        ],
                      ),
                      const VerticalSpace(height: .02),
                      //login button
                      SizedBox(
                        width: Responsive.getWidth(context) * .85,
                        height: Responsive.getHeight(context) * .05,
                        child: ElevatedButton(
                            key: const Key('loginButton'),
                            onPressed: () {
                              onLoginClick(ref);
                            },
                            child: AutoSizeText(
                              S.of(context).loginScreen_signInButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w900),
                            )),
                      ),
                      const VerticalSpace(height: .05),
                      SizedBox(
                        width: Responsive.getWidth(context) * .90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            AutoSizeText(
                              S.of(context).loginScreen_createDividerText,
                              maxLines: 1,
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const VerticalSpace(height: .06),
                      //go to signup page button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeText(
                            S.of(context).loginScreen_dontHaveAnAccountText,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              return TextButton(
                                key: const Key('toggleLoginPageButton'),
                                onPressed: () =>
                                    ref.read(loginSignUpToggleProvider.notifier).toggle(),
                                child: AutoSizeText(
                                  S.of(context).loginScreen_signUp,
                                  maxLines: 1,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}
