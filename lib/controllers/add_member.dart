import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/models/user.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class AddMemberController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> onAddMember(BuildContext context) async {
    try {
      if (!validate(context)) {
        return;
      }
      isLoading.value = true;
      FirebaseApp secondaryApp = await Firebase.initializeApp(
        name: 'secondaryApp',
        options: Firebase.app().options,
      );
      final user = await FirebaseAuth.instanceFor(app: secondaryApp)
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      final model = UserModel(
        uid: user.user!.uid,
        isLoggedIn: false,
        fcmToken: "",
        mosqueAddress: "",
        name: nameController.text,
        email: emailController.text,
        mosqueImage: null,
        mosqueID: authController.currentUser?.uid ?? "",
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
        postsCount: 0,
        role: UserRole.member,
      );
      await firestore
          .collection(DbCollections.users)
          .doc(user.user!.uid)
          .set(model.toJson());
      showCustomSnackbar(context, false, "Member created successfully.");
      Get.back();
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

  void getData(UserModel user) {
    nameController.text = user.name;
    emailController.text = user.email;
  }

  Future<void> onUpdateMember(BuildContext context, UserModel user) async {
    try {
      if (nameController.text.isEmpty) {
        showCustomSnackbar(context, true, "Please enter a full name.");
        return;
      }
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      await firestore.collection(DbCollections.users).doc(user.uid).update({
        "name": nameController.text,
      });
      showCustomSnackbar(context, false, "Member updated successfully.");
      Get.back();
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

  bool validate(BuildContext context) {
    if (nameController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter a full name.");
      return false;
    }
    if (emailController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter an email.");
      return false;
    }
    if (!emailController.text.isEmail) {
      showCustomSnackbar(context, true, "Please enter a valid email.");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter a password.");
      return false;
    }
    if (passwordController.text.length < 6) {
      showCustomSnackbar(
        context,
        true,
        "Password must be at least 6 characters.",
      );
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      showCustomSnackbar(context, true, "Please enter a confirm password.");
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showCustomSnackbar(context, true, "Passwords do not match.");
      return false;
    }

    return true;
  }
}
