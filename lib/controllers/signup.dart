import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mosqueconnect/views/widgets/media_picker.dart';

class SignupController extends GetxController {
  RxString pickedImage = "".obs;
  TextEditingController mosqueNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void pickImage() async {
    final image = await Get.bottomSheet(MediaPicker());
    if (image != null) {
      pickedImage.value = image;
    }
  }
}
