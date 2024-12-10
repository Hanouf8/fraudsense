import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:intl/intl.dart' as intl;

class LanguageManager {
  static TextDirection isDirectionRTL(BuildContext context) {
    bool isRTL = intl.Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);

    if (isRTL) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  static TextDirection textDirectionFromLang({required WidgetRef ref}) {
    TextDirection textDirection = ref.watch(languageProvider.notifier).textDirectionFromLang();

    print(textDirection);

    return textDirection;
  }

  static String localizeFirebaseExceptionError(
      {required BuildContext context, required String errorCode}) {
    switch (errorCode) {
      case "invalid-credential":
        return S.of(context).firebaseAuthErrorCodes_invalid_credential;
      case "invalid-email":
        return S.of(context).firebaseAuthErrorCodes_invalid_email;
      case "user-not-found":
        return S.of(context).firebaseAuthErrorCodes_user_not_found;
      case "wrong-password":
        return S.of(context).firebaseAuthErrorCodes_wrong_password;
      case "user-disabled":
        return S.of(context).firebaseAuthErrorCodes_user_disabled;
      case "email-already-in-use":
        return S.of(context).firebaseAuthErrorCodes_email_already_in_use;
      case "user-name-taken":
        return S.of(context).firebaseAuthErrorCodes_username_taken;
      case "weak-password":
        return S.of(context).firebaseAuthErrorCodes_weak_password;
      case "long-username":
        return S.of(context).firebaseAuthErrorCodes_long_username;
      default:
        return "Error message: $errorCode";
    }
  }
}
