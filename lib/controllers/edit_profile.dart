import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/services/cloudinary.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';
import 'package:mosqueconnect/views/widgets/media_picker.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString pickedImage = "".obs;
  TextEditingController mosqueNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void pickImage() async {
    final image = await Get.bottomSheet(MediaPicker());
    if (image != null) {
      pickedImage.value = image;
    }
  }

  void getData() {
    mosqueNameController.text = authController.currentUser?.name ?? "";
    emailController.text = authController.currentUser?.email ?? "";
  }

  Future<void> updateProfile(BuildContext context) async {
    try {
      if (mosqueNameController.text.isEmpty) {
        showCustomSnackbar(context, true, "Please enter a mosque name.");
        return;
      }

      FocusScope.of(context).unfocus();
      isLoading.value = true;
      String? imageUrl = authController.userMosque?.mosqueImage;
      if (pickedImage.value.isNotEmpty) {
        imageUrl = await CloudinaryService.uploadFile(pickedImage.value);
      }
      await firestore
          .collection(DbCollections.users)
          .doc(authController.currentUser!.uid)
          .update({
            'name': mosqueNameController.text,
            'mosqueImage': imageUrl,
            'updatedAt': DateTime.now().toUtc(),
          });
      await authController.getUser();
      showCustomSnackbar(context, false, "Profile updated successfully");
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      if (e is FirebaseException) {
        showCustomSnackbar(context, true, e.message ?? "Something went wrong");
      } else {
        showCustomSnackbar(context, true, "Something went wrong");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
