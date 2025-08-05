import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/models/post.dart';
import 'package:mosqueconnect/services/cloudinary.dart';
import 'package:mosqueconnect/utils/file_type.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class AddPostController extends GetxController {
  RxBool isLoading = false.obs;
  RxString postMedia = "".obs;
  RxString postMediaUrl = "".obs;
  TextEditingController postDescription = TextEditingController();

  void removeMedia() {
    postMedia.value = "";
    postMediaUrl.value = "";
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

  Future<void> onAddPost(BuildContext context) async {
    try {
      isLoading.value = true;
      if (postDescription.text.isEmpty && postMedia.value.isEmpty) {
        showCustomSnackbar(
          context,
          true,
          "Please enter a description or add media.",
        );
        return;
      }
      FocusScope.of(context).unfocus();
      String? imageUrl = postMedia.value.isNotEmpty
          ? await CloudinaryService.uploadFile(postMedia.value)
          : null;
      final postID = DateTime.now().millisecondsSinceEpoch.toString();
      final post = PostModel(
        id: postID,
        isActive: true,
        viewers: [],
        searchKey: postDescription.text.toLowerCase().trim(),
        description: postDescription.text,
        mediaUrl: imageUrl,
        isVideo: FileTypeUtils.isVideo(postMedia.value),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: authController.currentUser?.uid ?? "",
      );
      await firestore
          .collection(DbCollections.mosquePosts)
          .doc(postID)
          .set(post.toJson());
      showCustomSnackbar(context, false, "Post added successfully.");
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

  Future<void> onUpdatePost(BuildContext context, PostModel post) async {
    try {
      isLoading.value = true;
      if (postDescription.text.isEmpty &&
          (postMedia.value.isEmpty && postMediaUrl.value.isEmpty)) {
        showCustomSnackbar(
          context,
          true,
          "Please enter a description or add media.",
        );
        return;
      }
      FocusScope.of(context).unfocus();
      String? imageUrl;
      if (postMedia.value.isNotEmpty) {
        imageUrl = await CloudinaryService.uploadFile(postMedia.value);
      } else if (postMediaUrl.value.isNotEmpty) {
        imageUrl = postMediaUrl.value;
      } else {
        imageUrl = null;
      }

      await firestore
          .collection(DbCollections.mosquePosts)
          .doc(post.id)
          .update({
            "description": postDescription.text,
            "mediaUrl": imageUrl,
            "updatedAt": DateTime.now().toUtc(),
          });
      showCustomSnackbar(context, false, "Post updated successfully.");
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

  Future<void> getData(PostModel post) async {
    postDescription.text = post.description;
    postMediaUrl.value = post.mediaUrl ?? "";
  }
}
