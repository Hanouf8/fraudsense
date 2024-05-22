import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fraudsense/core/network/internet_connection.dart';
import 'package:fraudsense/screens/signup_screen/model/user_model.dart';
import 'package:meta/meta.dart';

part 'firebase_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit() : super(FirebaseInitial());
}
