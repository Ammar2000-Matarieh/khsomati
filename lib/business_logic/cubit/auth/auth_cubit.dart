import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userModel;

  Future sendCode({required String phone}) async {
    emit(AuthLoading());
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+962$phone',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCredential = await auth.signInWithCredential(credential);
          userModel = UserModel(
            id: userCredential.user?.uid,
            phone: userCredential.user?.phoneNumber,
          );
          emit(AuthLogedIn());
        },
        verificationFailed: (FirebaseAuthException error) {
          emit(AuthError("messege : $error"));
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          emit(CodeSentState(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthError("messege : $e"));
    }
  }

  Future verifyCode({
    required String verificationId,
    required String smsCode,
  }) async {
    emit(AuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential = await auth.signInWithCredential(credential);

      userModel = UserModel(
        id: userCredential.user!.uid,
        phone: userCredential.user!.phoneNumber,
        token: await userCredential.user!.getIdToken(),
      );

      final id = userCredential.user?.uid;
      final exists = await checkIfUserExists(id ?? "");
      if (exists) {
        await login(id ?? "");
      } else {
        emit(AuthUserNotExists());
      }
    } catch (e) {
      emit(AuthError("message : $e"));
      print(e);
    }
  }

  Future<bool> checkIfUserExists(String id) async {
    final doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .get();
    return doc.exists;
  }

  Future<void> createAccount({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String date,
  }) async {
    emit(AuthLoading());
    userModel?.firstName = firstName;
    userModel?.lastName = lastName;
    userModel?.email = email;
    userModel?.gender = gender;
    userModel?.date = date;

    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userModel?.id)
          .set(userModel!.toJson());

      emit(AuthLogedIn());
    } catch (e) {
      AuthError("message : $e");
    }
  }

  Future<void> login(String id) async {
    final doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .get();
    if (doc.exists) {
      try {
        final data = doc.data();
        userModel = UserModel.fromJson(data as Map<String, dynamic>);
        emit(AuthLogedIn());
      } catch (e) {
        AuthError("message : $e");
      }
    }
  }
}
