part of 'firebase_cubit.dart';

@immutable
sealed class FirebaseState {}

final class FirebaseInitial extends FirebaseState {}

class CreateUserInDatabaseLoadingState extends FirebaseState {}

class CreateUserInDatabaseSuccessState extends FirebaseState {}

class CreateUserInDatabaseErrorState extends FirebaseState {
  final String error;

  CreateUserInDatabaseErrorState({required this.error});
}
