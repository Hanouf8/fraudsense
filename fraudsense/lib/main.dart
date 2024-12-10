import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/core/theme/theme.dart';
import 'package:fraudsense/firebase_options.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/root_screen.dart';
import 'package:fraudsense/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void precacheImages(BuildContext context) {
    precacheImage(const AssetImage('assets/images/character/character_speak.png'), context);
    precacheImage(const AssetImage('assets/images/character/character_hint.png'), context);
    precacheImage(const AssetImage('assets/images/character/character_think.png'), context);
    precacheImage(const AssetImage('assets/images/welcome_image.png'), context);
    precacheImage(const AssetImage('assets/images/login_image.jpeg'), context);
  }

  void preLoadSoundsId() async {
    SoundManager soundManager = SoundManager.instance;
    await soundManager.loadSound("assets/audio/tab.wav", "tab");
    await soundManager.loadSound("assets/audio/tab1.wav", "tab1");
    await soundManager.loadSound("assets/audio/pop_up.wav", "popUp");
    await soundManager.loadSound("assets/audio/wrong_answer.wav", "wrongAnswer");
    await soundManager.loadSound("assets/audio/right_answer.wav", "rightAnswer");
    await soundManager.loadSound("assets/audio/tick2.wav", "tick");
    await soundManager.loadSound("assets/audio/hint_show.wav", "hintShow");
  }

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    preLoadSoundsId();
    return Consumer(builder: (context, ref, child) {
      Locale locale = ref.watch(localeProvider);

      FirebaseAuth auth = ref.read(firebaseAuthProvider);
      bool userIsAlreadyLoggedIn = auth.currentUser != null;

      return MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: userIsAlreadyLoggedIn ? const RootScreen() : const SplashScreen(),
      );
    });
  }
}
