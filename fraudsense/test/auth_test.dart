import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/cloud/cloud_services.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

// @GenerateNiceMocks([MockSpec<CloudServices>(), MockSpec<UserCredential>(), MockSpec<User>()])
// import 'auth_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<UserCredential>()])

class MockCloudServices extends Mock implements CloudServices {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late CloudServices mockCloudServices;
  late CloudController cloudController;

  setUp(() {
    mockCloudServices = MockCloudServices();
    cloudController = CloudController(mockCloudServices);
  });

  group("Login tests", () {
    test("Logging in with incorrect password", () async {
      const email = "example@gmail.com";
      const password = "wrongPassword";

      //throwing a FirebaseAuthException with code "wrong-password"
      when(() => mockCloudServices.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: "wrong-password"));

      Result result = await cloudController.logIn(email: email, password: password);

      //expecting our results from the signUp method to be an error message to be "wrong-password"
      expect(result.error, "wrong-password");
    });

    test("Logging in with correct password", () async {
      const email = "example@gmail.com";
      const password = "password";

      //returning a MockUserCredential
      when(() => mockCloudServices.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) => Future.value(MockUserCredential()));

      Result result = await cloudController.logIn(email: email, password: password);
      //expecting our results from the signUp method to be a success bool to be true and error message to be null
      expect(result.isSuccess, true);
      expect(result.error, null);
    });
  });

  group("Sign up tests", () {
    test("Signing up with valid email", () async {
      const email = "example@gmail.com";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "userName";
      const userUid = "123123";

      //mocking the user credential and user
      UserCredential mockedUserCredential = MockUserCredential();
      User mockedUser = MockUser();

      //when we try to get the user UID from the mockedUser we should get the userUid
      when(() => mockedUser.uid).thenReturn(userUid);
      //when we try to get the user object from the mockedUserCredential we should get the mockedUser with the fed UID
      when(() => mockedUserCredential.user).thenReturn(mockedUser);

      //returning false because the user name is not taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(false));

      //will return void because we successfully stored the user data in the database, otherwise we should return an error
      when(() => mockCloudServices.generateUserDataInDatabase(
            userUid: userUid,
            email: email,
            userName: userName,
            surName: surName,
            preferredLanguage: AppLanguage.en,
          )).thenAnswer((_) => Future.value());

      //returning a MockUserCredential when we call createUserWithEmailAndPassword as if we were signing up
      when(() => mockCloudServices.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) => Future.value(mockedUserCredential));

      Result result = await cloudController.signUp(
          email: email,
          password: password,
          userName: userName,
          surName: surName,
          preferredLanguage: AppLanguage.en);
      //expecting our results from the signUp method to be a success bool to be true

      expect(result.isSuccess, true);
    });

    test("Signing up with invalid email", () async {
      const email = "example";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "userName";

      //returning false because the user name is not taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(false));

      //when we try to return a user credential we should throw a firebase auth exception
      //because we call createUserWithEmailAndPassword and the email is invalid automatically by firebase
      when(() => mockCloudServices.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: "invalid-email"));

      Result result = await cloudController.signUp(
        email: email,
        password: password,
        preferredLanguage: AppLanguage.en,
        userName: userName,
        surName: surName,
      );

      //expecting our results from the signUp method to be an error message to be "invalid-email"
      expect(result.error, "invalid-email");
    });

    test("Signing up with incorrect password format", () async {
      const email = "example";
      const password = "123123";
      const surName = "surName";
      const userName = "userName";

      Result result = await cloudController.signUp(
          email: email,
          password: password,
          preferredLanguage: AppLanguage.en,
          userName: userName,
          surName: surName);
      //expecting our results from the signUp method to be an error with the error message "weak-password"

      expect(result.error, "weak-password");
    });

    test("Signing up with valid password", () async {
      const email = "example@gmail.com";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "userName";
      const userUid = "123123";

      //mocking the user credential and user
      UserCredential mockedUserCredential = MockUserCredential();
      User mockedUser = MockUser();

      //when we try to get the user UID from the mockedUser we should get the userUid
      when(() => mockedUser.uid).thenReturn(userUid);
      //when we try to get the user object from the mockedUserCredential we should get the mockedUser with the fed UID
      when(() => mockedUserCredential.user).thenReturn(mockedUser);

      //returning false because the user name is not taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(false));

      //will return void because we successfully stored the user data in the database, otherwise we should return an error
      when(() => mockCloudServices.generateUserDataInDatabase(
            userUid: userUid,
            email: email,
            userName: userName,
            surName: surName,
            preferredLanguage: AppLanguage.en,
          )).thenAnswer((_) => Future.value());

      //returning a MockUserCredential when we call createUserWithEmailAndPassword as if we were signing up
      when(() => mockCloudServices.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) => Future.value(mockedUserCredential));

      Result result = await cloudController.signUp(
          email: email,
          password: password,
          preferredLanguage: AppLanguage.en,
          userName: userName,
          surName: surName);

      //expecting our results from the signUp method to be a success bool to be true
      expect(result.isSuccess, true);
    });

    test("Signing up with a taken user name", () async {
      const email = "example@gmail.com";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "takenUserName";
      const userUid = "123123";

      //mocking the user credential and user
      UserCredential mockedUserCredential = MockUserCredential();
      User mockedUser = MockUser();

      //when we try to get the user UID from the mockedUser we should get the userUid
      when(() => mockedUser.uid).thenReturn(userUid);
      //when we try to get the user object from the mockedUserCredential we should get the mockedUser with the fed UID
      when(() => mockedUserCredential.user).thenReturn(mockedUser);

      //returning true because the user name is taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(true));

      //will return void because we successfully stored the user data in the database, otherwise we should return an error
      when(() => mockCloudServices.generateUserDataInDatabase(
            userUid: userUid,
            email: email,
            userName: userName,
            surName: surName,
            preferredLanguage: AppLanguage.en,
          )).thenAnswer((_) => Future.value());

      //returning a MockUserCredential when we call createUserWithEmailAndPassword as if we were signing up
      when(() => mockCloudServices.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenAnswer((_) => Future.value(mockedUserCredential));

      Result result = await cloudController.signUp(
          email: email,
          password: password,
          preferredLanguage: AppLanguage.en,
          userName: userName,
          surName: surName);
      //expecting our results from the signUp method to be an error with the error message "user-name-taken"

      expect(result.error, "user-name-taken");
    });

    test("Signing up with a long user name", () async {
      const email = "example@gmail.com";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "PrettyLongUsernameThatsOver20CharactersLong";

      //returning false because the user name is not taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(false));

      Result result = await cloudController.signUp(
          email: email,
          password: password,
          preferredLanguage: AppLanguage.en,
          userName: userName,
          surName: surName);

      //expecting our results from the signUp method to be an error with the error message "long-username"
      expect(result.error, "long-username");
    });

    test("Signing up with an already used email", () async {
      const email = "takenEmail@gmail.com";
      const password = "StrongPassword123123";
      const surName = "surName";
      const userName = "userName";

      //returning false because the user name is not taken
      when(() => mockCloudServices.isUserNameTaken(
            userName: userName,
          )).thenAnswer((_) => Future.value(false));

      //when we try to return a user credential we should throw a firebase auth exception
      //because we call createUserWithEmailAndPassword and the email is already taken in the database
      when(() => mockCloudServices.createUserWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: "email-already-in-use"));

      //expecting our results from the signUp method to be an error with the error message "email-already-in-use"
      Result result = await cloudController.signUp(
          email: email,
          password: password,
          preferredLanguage: AppLanguage.en,
          userName: userName,
          surName: surName);

      expect(result.error, "email-already-in-use");
    });
  });
}
