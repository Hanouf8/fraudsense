import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/languages_button.dart';
import 'package:fraudsense/core/components/sign_out_button.dart';
import 'package:fraudsense/core/components/sign_out_pop_up.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/tabs/front_tab.dart';
import 'package:fraudsense/screens/tabs/game_level_selection_tab.dart';
import 'package:fraudsense/screens/tabs/profile_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Widget> tabs = [
    const FrontTab(),
    const LevelSelectionTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    int tabIndex = ref.watch(homeTabIndexProvider);
    UserDataModel userData = ref.watch(userDataProvider);

    bool userDataIsLoaded = userData.uid != "";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (tabIndex == 0) {
          signOutPopUp(context: context);
        } else {
          ref.read(homeTabIndexProvider.notifier).state = 0;
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: AppBar(
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4.0),
                  child: Container(
                    color: Colors.green,
                    height: 2.0,
                  )),
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                "FraudSense",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              leading: const SignOutButton(),
              actions: const [LanguageButton()],
            ),
          ),
        ),
        body: userDataIsLoaded
            ? tabs[tabIndex]
            : Center(
                child: Text(
                  S.of(context).levelsTab_loading,
                  textDirection: ref.read(languageProvider.notifier).textDirectionFromLang(),
                ),
              ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: tabIndex,
              onTap: (index) {
                ref.read(homeTabIndexProvider.notifier).state = index;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.gamepad,
                      color: Colors.black,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    label: ''),
              ]),
        ),
      ),
    );
  }
}
