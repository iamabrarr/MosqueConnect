import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/instances.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Future<void> sendResetPasswordEmail() async {
    await auth.sendPasswordResetEmail(email: emailController.text);
    emailController.clear();
  }
}
