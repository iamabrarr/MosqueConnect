import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLogin(BuildContext context) async {
    try {
      isLoading.value = true;
      if (_validator(context)) {
        final user = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (user.user != null) {
          showCustomSnackbar(context, false, "Welcome back!👋🏻");
          await authController.initialRoot();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (e is FirebaseAuthException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else {
        showCustomSnackbar(context, true, "Something went wrong");
      }
    } finally {
      isLoading.value = false;
    }
  }

  bool _validator(BuildContext context) {
    if (emailController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter your email");
      return false;
    }
    if (!emailController.text.isEmail) {
      showCustomSnackbar(context, true, "Please enter a valid email");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter your password");
      return false;
    }
    return true;
  }
}
