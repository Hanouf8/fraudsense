import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/components/languages_button.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/utils/responsive.dart';
import 'package:fraudsense/screens/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpace(height: .01),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[LanguageButton()],
            ),
            const VerticalSpace(height: .05),
            AutoSizeText(
              'FraudSense',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: const Color.fromARGB(148, 255, 82, 82),
                  fontWeight: FontWeight.w800),
              maxLines: 1,
            ),
            const VerticalSpace(height: .02),
            AutoSizeText(
              'Protect yourself from Whatsapp \n phishing and fraud',
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            const VerticalSpace(height: .10),
            Image.asset(
              'assets/images/welcome_image.png',
              height: Responsive.getHeight(context) * .45,
              width: double.infinity,
            ),
            const VerticalSpace(height: .02),
            SizedBox(
              width: Responsive.getWidth(context) * .80,
              height: Responsive.getHeight(context) * .05,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const MainScreen())));
                  },
                  child: AutoSizeText(
                    'Get Started',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w900),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
