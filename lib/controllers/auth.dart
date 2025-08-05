import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/views/pages/auth/onboarding/onboarding.dart';
import 'package:mosqueconnect/views/widgets/bottom_nav_bar.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class AuthController extends GetxController {
  final Rxn<UserModel> _userMosque = Rxn<UserModel>();
  UserModel? get userMosque => _userMosque.value;

  final Rxn<UserModel> _currentUser = Rxn<UserModel>();
  UserModel? get currentUser => _currentUser.value;

  Future<void> initialRoot() async {
    await getUser();
    final user = currentUser;
    if (user != null) {
      Get.offAll(() => CustomBottomNavBar());
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  Future<void> getUser() async {
    final currenUserID = auth.currentUser?.uid;
    if (currenUserID != null) {
      final user = await firestore
          .collection(DbCollections.users)
          .doc(currenUserID)
          .get();
      log(user.data().toString());
      log(user.id);
      _currentUser.value = UserModel.fromDocumentSnapshot(user);
      //Get Mosque If user is member
      if (currentUser!.role == UserRole.member) {
        final mosque = await firestore
            .collection(DbCollections.users)
            .doc(currentUser!.mosqueID)
            .get();
        _userMosque.value = UserModel.fromDocumentSnapshot(mosque);
      } else {
        _userMosque.value = currentUser;
      }
      //Refresh fcm token
      _refreshFcmToken();
    }
  }

  Future<void> _refreshFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await firestore
          .collection(DbCollections.users)
          .doc(auth.currentUser?.uid)
          .update({"fcmToken": fcmToken, "isLoggedIn": true});
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      _clearUser();
      showCustomSnackbar(context, false, "Signed out successfully");
      Get.offAll(() => const OnboardingScreen());
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (e is FirebaseException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else if (e is FirebaseAuthException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else {
        showCustomSnackbar(context, true, "Something went wrong");
      }
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await auth.currentUser?.delete();
      await firestore
          .collection(DbCollections.users)
          .doc(auth.currentUser?.uid)
          .delete();
      _clearUser();
      showCustomSnackbar(context, false, "Account deleted successfully");
      Get.offAll(() => const OnboardingScreen());
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (e is FirebaseException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else if (e is FirebaseAuthException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else {
        showCustomSnackbar(context, true, "Something went wrong");
      }
    }
  }

  _clearUser() {
    _currentUser.value = null;
    _userMosque.value = null;
  }
}
