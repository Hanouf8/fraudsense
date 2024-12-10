import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/date_utilities.dart';
import 'package:fraudsense/models/user_data_model.dart';

//The CloudServices class contains just the methods for firebase operations
//it is the better approach for testability and maintainability and
//makes it easy to mock CloudServices and test AuthController in
//isolation without relaying on the actual firebase implementation

//errors are being handled in the AuthController
class CloudServices {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  CloudServices(this._firebaseAuth, this._firebaseFirestore);

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    //return an error when the account is disabled due to too many failed login attempts
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> generateUserDataInDatabase({
    required String userUid,
    required String userName,
    required String email,
    required String surName,
    required AppLanguage preferredLanguage,
  }) async {
    UserDataModel userModel = UserDataModel(
      uid: userUid,
      userName: userName,
      email: email,
      surName: surName,
      preferredLanguage: preferredLanguage,
      unlockedLevelsIndex: 0,
      availableHints: 3,
      unlockedHints: {},
      solvedScenarios: {},
      currency: 0,
      gameScore: 0,
      lastLoggedInDate: DateUtilities.getCurrentDate(),
      loggedInDays: 1,
      correctAnswersSolved: 0,
      wrongAnswersSolved: 0,
      currentStreak: 0,
      longestStreak: 0,
      solvedTimeForScenarios: {},
      scenariosFails: {},
    );

    return await _firebaseFirestore.collection('users').doc(userUid).set(userModel.toJson());
  }

  Future<UserDataModel> fetchUserData({required String userUid}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firebaseFirestore.collection('users').doc(userUid).get();

    return UserDataModel.fromJson(documentSnapshot.data()!);
  }

  Future<void> updateUserData(
      {required String userUid, required UserDataModel userDataModel}) async {
    await _firebaseFirestore.collection('users').doc(userUid).update(userDataModel.toJson());
  }

  Future resetPassword({required String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isUserNameTaken({required String userName}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('users').where('userName', isEqualTo: userName).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<List<UserDataModel>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection('users').get();

    List<UserDataModel> usersData =
        snapshot.docs.map((e) => UserDataModel.fromJson(e.data())).toList();

    return usersData;
  }
}
