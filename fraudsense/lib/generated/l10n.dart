// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Get Started`
  String get splashScreenButton {
    return Intl.message(
      'Get Started',
      name: 'splashScreenButton',
      desc: '',
      args: [],
    );
  }

  /// `Protect yourself from Whatsapp phishing and fraud`
  String get splashScreenText {
    return Intl.message(
      'Protect yourself from Whatsapp phishing and fraud',
      name: 'splashScreenText',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginScreen_emailField {
    return Intl.message(
      'Email',
      name: 'loginScreen_emailField',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginScreen_passwordField {
    return Intl.message(
      'Password',
      name: 'loginScreen_passwordField',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get loginScreen_forgotPasswordText {
    return Intl.message(
      'Forgot your password?',
      name: 'loginScreen_forgotPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get loginScreen_signInButton {
    return Intl.message(
      'Sign In',
      name: 'loginScreen_signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get loginScreen_createDividerText {
    return Intl.message(
      'Create',
      name: 'loginScreen_createDividerText',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get loginScreen_dontHaveAnAccountText {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginScreen_dontHaveAnAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get loginScreen_signUp {
    return Intl.message(
      'Sign Up',
      name: 'loginScreen_signUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password.`
  String get resetPasswordScreen_title {
    return Intl.message(
      'Enter your email to reset your password.',
      name: 'resetPasswordScreen_title',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get resetPasswordScreen_emailHint {
    return Intl.message(
      'Email',
      name: 'resetPasswordScreen_emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get resetPasswordScreen_emptyEmailFieldWarning {
    return Intl.message(
      'Please enter an email',
      name: 'resetPasswordScreen_emptyEmailFieldWarning',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get resetPasswordScreen_invalidEmailFieldWarning {
    return Intl.message(
      'Please enter a valid email',
      name: 'resetPasswordScreen_invalidEmailFieldWarning',
      desc: '',
      args: [],
    );
  }

  /// `Send reset email`
  String get resetPasswordScreen_resetButton {
    return Intl.message(
      'Send reset email',
      name: 'resetPasswordScreen_resetButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpScreen_titleSignUpText {
    return Intl.message(
      'Sign Up',
      name: 'signUpScreen_titleSignUpText',
      desc: '',
      args: [],
    );
  }

  /// `Join FraudSense to start learning now`
  String get signUpScreen_titleText {
    return Intl.message(
      'Join FraudSense to start learning now',
      name: 'signUpScreen_titleText',
      desc: '',
      args: [],
    );
  }

  /// `Your Surname`
  String get signUpScreen_surnameField {
    return Intl.message(
      'Your Surname',
      name: 'signUpScreen_surnameField',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get signUpScreen_emailField {
    return Intl.message(
      'Your Email',
      name: 'signUpScreen_emailField',
      desc: '',
      args: [],
    );
  }

  /// `Your Username`
  String get signUpScreen_usernameField {
    return Intl.message(
      'Your Username',
      name: 'signUpScreen_usernameField',
      desc: '',
      args: [],
    );
  }

  /// `Your Password`
  String get signUpScreen_passwordField {
    return Intl.message(
      'Your Password',
      name: 'signUpScreen_passwordField',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get signUpScreen_confirmPasswordField {
    return Intl.message(
      'Confirm Password',
      name: 'signUpScreen_confirmPasswordField',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get signUpScreen_getStartedButton {
    return Intl.message(
      'Get Started',
      name: 'signUpScreen_getStartedButton',
      desc: '',
      args: [],
    );
  }

  /// `Already a member?`
  String get signUpScreen_alreadyAMember {
    return Intl.message(
      'Already a member?',
      name: 'signUpScreen_alreadyAMember',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get signUpScreen_login {
    return Intl.message(
      'Login',
      name: 'signUpScreen_login',
      desc: '',
      args: [],
    );
  }

  /// `Your surname`
  String get signUpScreen_surnameFieldTitle {
    return Intl.message(
      'Your surname',
      name: 'signUpScreen_surnameFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get signUpScreen_emailFieldTitle {
    return Intl.message(
      'Your Email',
      name: 'signUpScreen_emailFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Username`
  String get signUpScreen_UsernameFieldTitle {
    return Intl.message(
      'Your Username',
      name: 'signUpScreen_UsernameFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose a secure password`
  String get signUpScreen_passwordFieldTitle {
    return Intl.message(
      'Choose a secure password',
      name: 'signUpScreen_passwordFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get signUpScreen_confirmPasswordFieldTitle {
    return Intl.message(
      'Confirm your password',
      name: 'signUpScreen_confirmPasswordFieldTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a surname`
  String get signUpScreen_enterSurnamePopUp {
    return Intl.message(
      'Please enter a surname',
      name: 'signUpScreen_enterSurnamePopUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email`
  String get signUpScreen_enterEmailPopUp {
    return Intl.message(
      'Please enter valid email',
      name: 'signUpScreen_enterEmailPopUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a username`
  String get signUpScreen_enterUsernamePopUp {
    return Intl.message(
      'Please enter a username',
      name: 'signUpScreen_enterUsernamePopUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get signUpScreen_enterPasswordPopUp {
    return Intl.message(
      'Please enter a password',
      name: 'signUpScreen_enterPasswordPopUp',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get signUpScreen_enterConfirmedPasswordPopUp {
    return Intl.message(
      'Please confirm your password',
      name: 'signUpScreen_enterConfirmedPasswordPopUp',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get signUpScreen_passwordNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'signUpScreen_passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `The credentials you entered are not correct`
  String get firebaseAuthErrorCodes_invalid_credential {
    return Intl.message(
      'The credentials you entered are not correct',
      name: 'firebaseAuthErrorCodes_invalid_credential',
      desc: '',
      args: [],
    );
  }

  /// `The email you entered is invalid`
  String get firebaseAuthErrorCodes_invalid_email {
    return Intl.message(
      'The email you entered is invalid',
      name: 'firebaseAuthErrorCodes_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `The account you entered is not found`
  String get firebaseAuthErrorCodes_user_not_found {
    return Intl.message(
      'The account you entered is not found',
      name: 'firebaseAuthErrorCodes_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is wrong`
  String get firebaseAuthErrorCodes_wrong_password {
    return Intl.message(
      'The password you entered is wrong',
      name: 'firebaseAuthErrorCodes_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `The account you're accessing is disabled`
  String get firebaseAuthErrorCodes_user_disabled {
    return Intl.message(
      'The account you\'re accessing is disabled',
      name: 'firebaseAuthErrorCodes_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `The email you entered is already in use`
  String get firebaseAuthErrorCodes_email_already_in_use {
    return Intl.message(
      'The email you entered is already in use',
      name: 'firebaseAuthErrorCodes_email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `The username you entered is already in use`
  String get firebaseAuthErrorCodes_username_taken {
    return Intl.message(
      'The username you entered is already in use',
      name: 'firebaseAuthErrorCodes_username_taken',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is weak. It must be at least 8 characters long and contains one upper case and one lower case letters`
  String get firebaseAuthErrorCodes_weak_password {
    return Intl.message(
      'The password you entered is weak. It must be at least 8 characters long and contains one upper case and one lower case letters',
      name: 'firebaseAuthErrorCodes_weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The maximum length of the username is 20 characters`
  String get firebaseAuthErrorCodes_long_username {
    return Intl.message(
      'The maximum length of the username is 20 characters',
      name: 'firebaseAuthErrorCodes_long_username',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get signOutButton_PopUpTitle {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutButton_PopUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Signed in as:`
  String get frontTab_singedInAsText {
    return Intl.message(
      'Signed in as:',
      name: 'frontTab_singedInAsText',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get frontTab_welcomeText {
    return Intl.message(
      'Welcome back',
      name: 'frontTab_welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Play a Game`
  String get frontTab_cardPlayGameTitle {
    return Intl.message(
      'Play a Game',
      name: 'frontTab_cardPlayGameTitle',
      desc: '',
      args: [],
    );
  }

  /// `Test your phishing detection skills`
  String get frontTab_cardPlayGameDescription {
    return Intl.message(
      'Test your phishing detection skills',
      name: 'frontTab_cardPlayGameDescription',
      desc: '',
      args: [],
    );
  }

  /// `View Leaderboard`
  String get frontTab_cardLeaderboardTitle {
    return Intl.message(
      'View Leaderboard',
      name: 'frontTab_cardLeaderboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Compare your phishing detection skills with other players`
  String get frontTab_cardLeaderboardDescription {
    return Intl.message(
      'Compare your phishing detection skills with other players',
      name: 'frontTab_cardLeaderboardDescription',
      desc: '',
      args: [],
    );
  }

  /// `View Progress`
  String get frontTab_cardProgressTitle {
    return Intl.message(
      'View Progress',
      name: 'frontTab_cardProgressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Track your progress and achievements`
  String get frontTab_cardProgressDescription {
    return Intl.message(
      'Track your progress and achievements',
      name: 'frontTab_cardProgressDescription',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get frontTab_statisticsTitle {
    return Intl.message(
      'Statistics',
      name: 'frontTab_statisticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Track your gameplay performance with detailed insights and analyze your progress`
  String get frontTab_statisticsDescription {
    return Intl.message(
      'Track your gameplay performance with detailed insights and analyze your progress',
      name: 'frontTab_statisticsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Levels`
  String get levelsTab_title {
    return Intl.message(
      'Levels',
      name: 'levelsTab_title',
      desc: '',
      args: [],
    );
  }

  /// `Loading..`
  String get levelsTab_loading {
    return Intl.message(
      'Loading..',
      name: 'levelsTab_loading',
      desc: '',
      args: [],
    );
  }

  /// `You selected level`
  String get levelsTab_levelPopUpSelectedLevel {
    return Intl.message(
      'You selected level',
      name: 'levelsTab_levelPopUpSelectedLevel',
      desc: '',
      args: [],
    );
  }

  /// `You haven't unlocked this level yet`
  String get levelsTab_levelPopUpLockedLevel {
    return Intl.message(
      'You haven\'t unlocked this level yet',
      name: 'levelsTab_levelPopUpLockedLevel',
      desc: '',
      args: [],
    );
  }

  /// `Start level`
  String get levelsTab_levelPopUpStartLevel {
    return Intl.message(
      'Start level',
      name: 'levelsTab_levelPopUpStartLevel',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get profileTab_achievements {
    return Intl.message(
      'Achievements',
      name: 'profileTab_achievements',
      desc: '',
      args: [],
    );
  }

  /// `Coins`
  String get profileTab_coins {
    return Intl.message(
      'Coins',
      name: 'profileTab_coins',
      desc: '',
      args: [],
    );
  }

  /// `Hints`
  String get profileTab_hints {
    return Intl.message(
      'Hints',
      name: 'profileTab_hints',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get profileTab_points {
    return Intl.message(
      'Points',
      name: 'profileTab_points',
      desc: '',
      args: [],
    );
  }

  /// `Completed Levels`
  String get profileTab_achievementsCompletedLevelsTitle {
    return Intl.message(
      'Completed Levels',
      name: 'profileTab_achievementsCompletedLevelsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complete All Levels`
  String get profileTab_achievementsCompletedLevelsBottomText {
    return Intl.message(
      'Complete All Levels',
      name: 'profileTab_achievementsCompletedLevelsBottomText',
      desc: '',
      args: [],
    );
  }

  /// `Points Gained`
  String get profileTab_achievementsPointsTitle {
    return Intl.message(
      'Points Gained',
      name: 'profileTab_achievementsPointsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reach`
  String get profileTab_achievementsPointsBottomText1 {
    return Intl.message(
      'Reach',
      name: 'profileTab_achievementsPointsBottomText1',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get profileTab_achievementsPointsBottomText2 {
    return Intl.message(
      'Points',
      name: 'profileTab_achievementsPointsBottomText2',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get game_submitButton {
    return Intl.message(
      'Submit',
      name: 'game_submitButton',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get game_popUpNext {
    return Intl.message(
      'Next',
      name: 'game_popUpNext',
      desc: '',
      args: [],
    );
  }

  /// `Quit`
  String get game_popUpQuit {
    return Intl.message(
      'Quit',
      name: 'game_popUpQuit',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get game_popUpExit {
    return Intl.message(
      'Exit',
      name: 'game_popUpExit',
      desc: '',
      args: [],
    );
  }

  /// `Next scenario`
  String get game_popUpNextScenario {
    return Intl.message(
      'Next scenario',
      name: 'game_popUpNextScenario',
      desc: '',
      args: [],
    );
  }

  /// `return to game`
  String get game_popUpReturnToGame {
    return Intl.message(
      'return to game',
      name: 'game_popUpReturnToGame',
      desc: '',
      args: [],
    );
  }

  /// `View mistakes`
  String get game_popUpViewMistakes {
    return Intl.message(
      'View mistakes',
      name: 'game_popUpViewMistakes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to quit?`
  String get game_confirmQuit {
    return Intl.message(
      'Are you sure you want to quit?',
      name: 'game_confirmQuit',
      desc: '',
      args: [],
    );
  }

  /// `Time has ran out!`
  String get game_popUpTimeRanOutTitle {
    return Intl.message(
      'Time has ran out!',
      name: 'game_popUpTimeRanOutTitle',
      desc: '',
      args: [],
    );
  }

  /// `You paused the game`
  String get game_popUpPauseTitle {
    return Intl.message(
      'You paused the game',
      name: 'game_popUpPauseTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have finished this scenario`
  String get game_popUpAlreadyFinishedScenario {
    return Intl.message(
      'You have finished this scenario',
      name: 'game_popUpAlreadyFinishedScenario',
      desc: '',
      args: [],
    );
  }

  /// `Show a hint`
  String get game_hintsPopUpShowHint {
    return Intl.message(
      'Show a hint',
      name: 'game_hintsPopUpShowHint',
      desc: '',
      args: [],
    );
  }

  /// `Buy a hint`
  String get game_hintsPopUpBuyHint {
    return Intl.message(
      'Buy a hint',
      name: 'game_hintsPopUpBuyHint',
      desc: '',
      args: [],
    );
  }

  /// `Amount of hints left in your account:`
  String get game_hintsPopUpTitle {
    return Intl.message(
      'Amount of hints left in your account:',
      name: 'game_hintsPopUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you wish to use one now?`
  String get game_hintsPopUpTitle1 {
    return Intl.message(
      'Do you wish to use one now?',
      name: 'game_hintsPopUpTitle1',
      desc: '',
      args: [],
    );
  }

  /// `You already unlocked this hint`
  String get game_hintsPopUpAlreadyUnlocked {
    return Intl.message(
      'You already unlocked this hint',
      name: 'game_hintsPopUpAlreadyUnlocked',
      desc: '',
      args: [],
    );
  }

  /// `you got it right! just in`
  String get game_rightAnswer {
    return Intl.message(
      'you got it right! just in',
      name: 'game_rightAnswer',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get game_rightAnswer1 {
    return Intl.message(
      'seconds',
      name: 'game_rightAnswer1',
      desc: '',
      args: [],
    );
  }

  /// `You got it wrong!`
  String get game_wrongAnswer {
    return Intl.message(
      'You got it wrong!',
      name: 'game_wrongAnswer',
      desc: '',
      args: [],
    );
  }

  /// `You finished the level, you got`
  String get game_endPopUpTitle {
    return Intl.message(
      'You finished the level, you got',
      name: 'game_endPopUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `answer(s) right out of`
  String get game_endPopUpTitle1 {
    return Intl.message(
      'answer(s) right out of',
      name: 'game_endPopUpTitle1',
      desc: '',
      args: [],
    );
  }

  /// `You finished the level, you got none of the questions right`
  String get game_endPopUpTitleAllWrong {
    return Intl.message(
      'You finished the level, you got none of the questions right',
      name: 'game_endPopUpTitleAllWrong',
      desc: '',
      args: [],
    );
  }

  /// `You picked this answer`
  String get game_mistakeSummaryPickedAnswer {
    return Intl.message(
      'You picked this answer',
      name: 'game_mistakeSummaryPickedAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Explanation`
  String get game_mistakeSummaryExplanation {
    return Intl.message(
      'Explanation',
      name: 'game_mistakeSummaryExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get game_leaderboardTitle {
    return Intl.message(
      'Leaderboard',
      name: 'game_leaderboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get game_leaderboardPoints {
    return Intl.message(
      'Points',
      name: 'game_leaderboardPoints',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get game_leaderboardUsername {
    return Intl.message(
      'Username',
      name: 'game_leaderboardUsername',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get statisticsScreen_generalTitleText {
    return Intl.message(
      'General',
      name: 'statisticsScreen_generalTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get statisticsScreen_streakTitleText {
    return Intl.message(
      'Streak',
      name: 'statisticsScreen_streakTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Levels`
  String get statisticsScreen_levelsTitleText {
    return Intl.message(
      'Levels',
      name: 'statisticsScreen_levelsTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Logged in days`
  String get statisticsScreen_loggedDays {
    return Intl.message(
      'Logged in days',
      name: 'statisticsScreen_loggedDays',
      desc: '',
      args: [],
    );
  }

  /// `Ranking`
  String get statisticsScreen_ranking {
    return Intl.message(
      'Ranking',
      name: 'statisticsScreen_ranking',
      desc: '',
      args: [],
    );
  }

  /// `Current Streak`
  String get statisticsScreen_currentStreak {
    return Intl.message(
      'Current Streak',
      name: 'statisticsScreen_currentStreak',
      desc: '',
      args: [],
    );
  }

  /// `Longest Streak`
  String get statisticsScreen_longestStreak {
    return Intl.message(
      'Longest Streak',
      name: 'statisticsScreen_longestStreak',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked Levels`
  String get statisticsScreen_unlockedLevels {
    return Intl.message(
      'Unlocked Levels',
      name: 'statisticsScreen_unlockedLevels',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get statisticsScreen_levelsListLevelTitle {
    return Intl.message(
      'Level',
      name: 'statisticsScreen_levelsListLevelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fails`
  String get statisticsScreen_levelsListFailsTitle {
    return Intl.message(
      'Fails',
      name: 'statisticsScreen_levelsListFailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Solve Time`
  String get statisticsScreen_levelsListSolveTimeTitle {
    return Intl.message(
      'Solve Time',
      name: 'statisticsScreen_levelsListSolveTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `No.`
  String get statisticsScreen_levelsListLevelNo {
    return Intl.message(
      'No.',
      name: 'statisticsScreen_levelsListLevelNo',
      desc: '',
      args: [],
    );
  }

  /// `Times`
  String get statisticsScreen_levelsListLevelFailTimes {
    return Intl.message(
      'Times',
      name: 'statisticsScreen_levelsListLevelFailTimes',
      desc: '',
      args: [],
    );
  }

  /// `Completed Levels`
  String get statisticsScreen_levelsListTitle {
    return Intl.message(
      'Completed Levels',
      name: 'statisticsScreen_levelsListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Want to buy a hint for 75 coins?`
  String get shopPopUp_canBuy {
    return Intl.message(
      'Want to buy a hint for 75 coins?',
      name: 'shopPopUp_canBuy',
      desc: '',
      args: [],
    );
  }

  /// `You don't have enough coins to buy a hint`
  String get shopPopUp_cantBuy {
    return Intl.message(
      'You don\'t have enough coins to buy a hint',
      name: 'shopPopUp_cantBuy',
      desc: '',
      args: [],
    );
  }

  /// `return`
  String get popUpReturn {
    return Intl.message(
      'return',
      name: 'popUpReturn',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get popUpConfirm {
    return Intl.message(
      'Confirm',
      name: 'popUpConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previousButton {
    return Intl.message(
      'Previous',
      name: 'previousButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
