import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/services/cloudinary.dart';
import 'package:mosqueconnect/views/widgets/bottom_nav_bar.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';
import 'package:mosqueconnect/views/widgets/media_picker.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxString pickedImage = "".obs;
  TextEditingController mosqueNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mosqueAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void pickImage() async {
    final image = await Get.bottomSheet(MediaPicker());
    if (image != null) {
      pickedImage.value = image;
    }
  }

  Future<void> onSignup(BuildContext context) async {
    try {
      isLoading.value = true;
      if (_validator(context)) {
        final imageUrl = await CloudinaryService.uploadFile(pickedImage.value, (
          count,
          total,
        ) {
          if (kDebugMode) {
            log('Uploading image from file with progress: $count/$total');
          }
        });
        final user = await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        if (user.user != null) {
          final model = UserModel(
            uid: user.user!.uid,
            mosqueImage: imageUrl,
            fcmToken: "",
            mosqueAddress: mosqueAddressController.text.trim(),
            name: mosqueNameController.text,
            email: emailController.text.trim(),
            mosqueID: "",
            isLoggedIn: true,
            createdAt: DateTime.now().toUtc(),
            updatedAt: DateTime.now().toUtc(),
            postsCount: 0,
            role: UserRole.mosque,
          );
          await firestore
              .collection(DbCollections.users)
              .doc(user.user!.uid)
              .set(model.toJson());
          showCustomSnackbar(
            context,
            false,
            "Congratulations!🎉 You are registered.",
          );
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
    if (pickedImage.value.isEmpty) {
      showCustomSnackbar(context, true, "Please upload mosque image");
      return false;
    }
    if (mosqueNameController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter mosque name");
      return false;
    }
    if (mosqueAddressController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter mosque address");
      return false;
    }
    if (emailController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter email");
      return false;
    }
    if (!emailController.text.isEmail) {
      showCustomSnackbar(context, true, "Please enter valid email");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter password");
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter confirm password");
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showCustomSnackbar(
        context,
        true,
        "Password and confirm password do not match",
      );
      return false;
    }
    return true;
  }
}
