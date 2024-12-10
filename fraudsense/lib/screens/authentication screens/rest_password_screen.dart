import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/core/components/app_text_form_field.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController forgottenEmailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CloudController cloudController = ref.watch(cloudControllerProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: Colors.green[200],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const VerticalSpace(height: 0.1),
          Text(
            S.of(context).resetPasswordScreen_title,
            style: const TextStyle(fontSize: 15),
          ),
          const VerticalSpace(height: .06),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.email),
                SizedBox(
                  width: Responsive.getWidth(context) * .80,
                  child: AppTextFormField(
                    controller: forgottenEmailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    hintText: S.of(context).resetPasswordScreen_emailHint,
                    validator: (email) {
                      if (email!.isEmpty) {
                        return S.of(context).resetPasswordScreen_emptyEmailFieldWarning;
                      } else if (!EmailValidator.validate(email)) {
                        return S.of(context).resetPasswordScreen_invalidEmailFieldWarning;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalSpace(height: .06),
          SizedBox(
            width: Responsive.getWidth(context) * .85,
            height: Responsive.getHeight(context) * .05,
            child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await cloudController.restPassword(email: forgottenEmailController.text.trim());
                    forgottenEmailController.text = "";
                  }
                },
                child: AutoSizeText(
                  S.of(context).resetPasswordScreen_resetButton,
                  style:
                      Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900),
                )),
          ),
          const VerticalSpace(height: 0.1),
        ],
      ),
    );
  }
}
