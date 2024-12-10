import 'package:firebase_auth/firebase_auth.dart';
import 'package:fraudsense/cloud/cloud_services.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/core/utils/validators.dart';
import 'package:fraudsense/models/user_data_model.dart';

//The CloudController handles exceptions and uses CloudServices to handle operations with firebase
class CloudController {
  final CloudServices _cloudServices;

  CloudController(this._cloudServices);

  Future<Result> logIn({required String email, required String password}) async {
    try {
      //return an error when the account is disabled due to too many failed login attempts inside the signInWithEmailAndPassword
      await _cloudServices.signInWithEmailAndPassword(email: email, password: password);

      return Result(data: "success");
    } on FirebaseAuthException catch (e) {
      return Result(error: e.code);
    } catch (error) {
      // General error handling for unexpected exceptions
      return Result(error: error.toString());
    }
  }

  Future<Result> signUp(
      {required String email,
      required String password,
      required String surName,
      required String userName,
      required AppLanguage preferredLanguage}) async {
    if (!Validators.validatePassword(password)) {
      return Result(error: "weak-password");
    }

    if (userName.length > 20) {
      return Result(error: "long-username");
    }

    try {
      bool isUserNameTake = await _cloudServices.isUserNameTaken(userName: userName);
      if (isUserNameTake) {
        return Result(error: "user-name-taken");
      }

      UserCredential userCredential =
          await _cloudServices.createUserWithEmailAndPassword(email: email, password: password);

      await _cloudServices.generateUserDataInDatabase(
          userUid: userCredential.user!.uid,
          userName: userName,
          email: email,
          surName: surName,
          preferredLanguage: preferredLanguage);

      return Result(data: "success");
    } on FirebaseAuthException catch (e) {
      return Result(error: e.code);
    } catch (error) {
      // General error handling for unexpected exceptions
      return Result(error: error.toString());
    }
  }

  Future<Result<UserDataModel>> fetchUserData({required String userUid}) async {
    try {
      final userDataModel = await _cloudServices.fetchUserData(userUid: userUid);
      return Result.success(userDataModel);
    } on FirebaseException catch (error) {
      return Result.failure(error.code);
    } catch (error) {
      return Result.failure(error.toString());
    }
  }

  Future<String> updateUserData(
      {required String userUid, required UserDataModel userDataModel}) async {
    try {
      await _cloudServices.updateUserData(userUid: userUid, userDataModel: userDataModel);
      return "success";
    } on FirebaseException catch (error) {
      return error.code;
    } catch (error) {
      // General error handling for unexpected exceptions
      return error.toString();
    }
  }

  Future<String> restPassword({required String email}) async {
    try {
      await _cloudServices.resetPassword(email: email);
      return "reset-link-sent";
    } on FirebaseException catch (e) {
      return e.code;
    } catch (error) {
      // General error handling for unexpected exceptions
      return error.toString();
    }
  }

  Future<Result<List<UserDataModel>>> getTopUsers() async {
    try {
      List<UserDataModel> usersData = await _cloudServices.getAllUsers();

      usersData.sort((a, b) => b.gameScore.compareTo(a.gameScore));

      return Result.success(usersData);
    } on FirebaseException catch (e) {
      return Result.failure(e.code);
    } catch (error) {
      // General error handling for unexpected exceptions
      return Result.failure(error.toString());
    }
  }

  Future<Result<int>> getUserRanking(String userName) async {
    try {
      List<UserDataModel> usersData = await _cloudServices.getAllUsers();
      usersData.sort((a, b) => b.gameScore.compareTo(a.gameScore));

      int index = usersData.indexWhere((element) => element.userName == userName);

      if (index == -1) {
        return Result.failure("user-not-found");
      }

      return Result.success(index + 1);
    } on FirebaseException catch (e) {
      return Result.failure(e.code);
    } catch (error) {
      // General error handling for unexpected exceptions
      return Result.failure(error.toString());
    }
  }
}
