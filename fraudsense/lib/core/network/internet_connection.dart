import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnection {
  final InternetConnectionChecker connectionChecker =
      InternetConnectionChecker();

  Future<bool> get isInternetConnected => connectionChecker.hasConnection;
}
