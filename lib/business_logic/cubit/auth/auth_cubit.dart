import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userModel;

  // إرسال كود التحقق (OTP)
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

          // final SharedPreferences sharedPreferences =
          //     await SharedPreferences.getInstance();

          // sharedPreferences.setString("id", userCredential.user!.uid);
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

      // save :
      // final SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();

      saveUser(userModel!);

      // sharedPreferences.setString('key_user_data', userJson);

      //         await sharedPreferences.setString("key", value)
    } catch (e) {
      emit(AuthError("message : $e"));
      print(e);
    }
  }

  Future<void> loadUserFromLocal() async {
    final storedUser = await getStoredUser();
    if (storedUser != null) {
      userModel = storedUser;
      emit(AuthLogedIn()); // سيحدث BlocBuilder مباشرة
    }
  }

  Future<void> saveUser(UserModel user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // 1. تحويل الكائن إلى Map
    Map<String, dynamic> userMap = user.toJson();

    // 2. تحويل الـ Map إلى سلسلة نصية JSON
    String userJson = jsonEncode(userMap);

    // 3. تخزين السلسلة النصية
    await sharedPreferences.setString('key_user_data', userJson);
  }

  // تأكد من استيراد مكتبة dart:convert لاستخدام jsonDecode

  Future<UserModel?> getStoredUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    // 1. استرداد السلسلة النصية المخزنة باستخدام نفس المفتاح
    String? userJson = sharedPreferences.getString('key_user_data');

    if (userJson == null) {
      return null; // لا يوجد بيانات مخزنة
    }

    // 2. تحويل سلسلة JSON إلى Map
    try {
      Map<String, dynamic> userMap = jsonDecode(userJson);

      // 3. إنشاء كائن UserModel من الـ Map
      UserModel user = UserModel.fromJson(userMap);

      return user;
    } catch (e) {
      // في حالة وجود مشكلة في فك الترميز
      print("Error decoding user data: $e");
      return null;
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

  Future<void> updateUserField({
    required String field,
    required String value,
  }) async {
    try {
      emit(AuthLoading());

      // 1. تحديث Firestore
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userModel!.id)
          .update({field: value});

      // 2. تحديث ال model داخل التطبيق
      userModel = userModel!.copyWithField(field, value);

      // 3. حفظ النسخة المحدثة في SharedPreferences
      await saveUser(userModel!);

      // 4. بث التحديث للتطبيق (مهم جدًا)
      emit(AuthLogedIn());
    } catch (e) {
      emit(AuthError("Update failed: $e"));
    }
  }
}
