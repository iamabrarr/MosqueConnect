import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostController extends GetxController {
  RxString postMedia = "".obs;
  TextEditingController postDescription = TextEditingController();

  void removeMedia() {
    postMedia.value = "";
  }

  void onCameraVideo() async {
    Get.back();
    final picker = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (picker != null) {
      postMedia.value = picker.path;
    }
  }

  void onCameraPhoto() async {
    Get.back();
    final picker = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picker != null) {
      postMedia.value = picker.path;
    }
  }

  void onGalleryVideo() async {
    Get.back();
    final picker = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picker != null) {
      postMedia.value = picker.path;
    }
  }

  void onGalleryPhoto() async {
    Get.back();
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      postMedia.value = picker.path;
    }
  }
}
