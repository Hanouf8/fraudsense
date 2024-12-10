import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/simple_pop_up.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/language/language_manager.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  onSignUpClick(WidgetRef ref) async {
    CloudController cloudController = ref.watch(cloudControllerProvider);

    ref.read(homeTabIndexProvider.notifier).state = 0;
    SoundManager.instance.playSound("tab");
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      Result signInResult = await cloudController.signUp(
          email: signupEmailController.text.trim(),
          password: signupPasswordController.text.trim(),
          userName: usernameController.text,
          surName: surnameController.text,
          preferredLanguage: ref.read(languageProvider));

      if (!signInResult.isSuccess) {
        String message = LanguageManager.localizeFirebaseExceptionError(
            context: context, errorCode: signInResult.error!);
        simplePopUp(message: message, context: context, ref: ref);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            ref.read(loginSignUpToggleProvider.notifier).toggle();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              key: const Key("scrollView"),
              padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //title
                    AutoSizeText(
                      S.of(context).signUpScreen_titleSignUpText,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color.fromARGB(206, 203, 240, 179),
                          fontWeight: FontWeight.w800),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalSpace(height: .01),
                    //description
                    AutoSizeText(
                      S.of(context).signUpScreen_titleText,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //surname field
                        const VerticalSpace(height: .03),
                        AutoSizeText(
                          S.of(context).signUpScreen_surnameFieldTitle,
                        ),
                        const VerticalSpace(height: .01),
                        AppTextFormField(
                          key: const Key("surNameField"),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                          ],
                          controller: surnameController,
                          keyboardType: TextInputType.text,
                          hintText: S.of(context).signUpScreen_surnameField,
                          fillColor: const Color.fromARGB(255, 211, 210, 210),
                          suffixIcon: const Icon(Icons.text_fields),
                          validator: (surname) {
                            if (surname!.isEmpty) {
                              simplePopUp(
                                  message: S.of(context).signUpScreen_enterSurnamePopUp,
                                  context: context,
                                  ref: ref);
                              return S.of(context).signUpScreen_enterSurnamePopUp;
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(height: .01),

                        //email field
                        AutoSizeText(S.of(context).signUpScreen_emailFieldTitle),
                        const VerticalSpace(height: .01),
                        AppTextFormField(
                          key: const Key("emailField"),
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: S.of(context).signUpScreen_emailField,
                          fillColor: const Color.fromARGB(255, 211, 210, 210),
                          suffixIcon: const Icon(Icons.email),
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
                        const VerticalSpace(height: .01),

                        //username field
                        AutoSizeText(S.of(context).signUpScreen_UsernameFieldTitle),
                        const VerticalSpace(height: .01),
                        AppTextFormField(
                          key: const Key("userNameField"),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                          ],
                          controller: usernameController,
                          keyboardType: TextInputType.name,
                          hintText: S.of(context).signUpScreen_usernameField,
                          fillColor: const Color.fromARGB(255, 211, 210, 210),
                          suffixIcon: const Icon(Icons.person),
                          validator: (username) {
                            if (username!.isEmpty) {
                              simplePopUp(
                                  message: S.of(context).signUpScreen_enterUsernamePopUp,
                                  context: context,
                                  ref: ref);

                              return S.of(context).signUpScreen_enterUsernamePopUp;
                            }
                            return null;
                          },
                        ),
                        const VerticalSpace(height: .01),

                        //password entering fields
                        buildPasswordFelids(),
                      ],
                    ),
                    const VerticalSpace(height: .05),

                    //sign up button
                    SizedBox(
                      width: Responsive.getWidth(context) * .95,
                      height: Responsive.getHeight(context) * .05,
                      child: ElevatedButton(
                        key: const Key("signUpButton"),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                        onPressed: () => onSignUpClick(ref),
                        child: AutoSizeText(
                          S.of(context).signUpScreen_getStartedButton,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),

                    const VerticalSpace(height: .05),

                    //go to login page button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          S.of(context).signUpScreen_alreadyAMember,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            return TextButton(
                              onPressed: () {
                                ref.read(loginSignUpToggleProvider.notifier).toggle();
                              },
                              child: AutoSizeText(
                                S.of(context).signUpScreen_login,
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
        );
      },
    );
  }

  Widget buildPasswordFelids() {
    return Consumer(
      builder: (context, ref, child) {
        final bool isPasswordVisible = ref.watch(passwordVisibilityProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(S.of(context).signUpScreen_passwordFieldTitle),
            const VerticalSpace(height: .01),
            AppTextFormField(
              key: const Key("passwordField"),
              controller: signupPasswordController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              hintText: S.of(context).signUpScreen_passwordField,
              fillColor: const Color.fromARGB(255, 211, 210, 210),
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
            const VerticalSpace(height: .01),
            AutoSizeText(S.of(context).signUpScreen_confirmPasswordFieldTitle),
            const VerticalSpace(height: .01),
            AppTextFormField(
              key: const Key("confirmPasswordField"),
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              hintText: S.of(context).signUpScreen_confirmPasswordField,
              fillColor: const Color.fromARGB(255, 211, 210, 210),
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
                      message: S.of(context).signUpScreen_enterConfirmedPasswordPopUp,
                      context: context,
                      ref: ref);

                  return S.of(context).signUpScreen_enterConfirmedPasswordPopUp;
                } else if (signupPasswordController.text != confirmPasswordController.text) {
                  simplePopUp(
                      message: S.of(context).signUpScreen_passwordNotMatch,
                      context: context,
                      ref: ref);

                  return S.of(context).signUpScreen_passwordNotMatch;
                }
                return null;
              },
            ),
          ],
        );
      },
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
