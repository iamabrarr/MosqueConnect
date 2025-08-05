import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/views/widgets/media_picker.dart';

class EditProfileController extends GetxController {
  RxString pickedImage = "".obs;
  TextEditingController mosqueNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void pickImage() async {
    final image = await Get.bottomSheet(MediaPicker());
    if (image != null) {
      pickedImage.value = image;
    }
  }
}
