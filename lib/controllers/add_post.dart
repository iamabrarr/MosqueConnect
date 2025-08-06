import 'dart:developer';
import 'dart:io';

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
import 'package:mosqueconnect/services/compressor.dart';
import 'package:mosqueconnect/utils/file_type.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';
import 'package:video_compress/video_compress.dart';

class AddPostController extends GetxController {
  RxDouble compressionProgress = 0.0.obs;
  RxDouble uploadProgress = 0.0.obs;
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
      _clearProgressValues();
      MediaInfo? compressionResult;
      //COMPRESS MEDIA
      if (postMedia.value.isNotEmpty) {
        compressionResult = await FileCompressor.compressVideoWithProgress(
          filePath: postMedia.value,
          onProgress: (progress) {
            compressionProgress.value = progress;
            if (kDebugMode) {
              log("COMPRESSING PROGRESS: $progress");
            }
          },
        );
      }
      if (kDebugMode && postMedia.value.isNotEmpty) {
        logFileSizes(postMedia.value, compressionResult?.file?.path);
      }
      compressionProgress.value = 0;
      uploadProgress.value = 1;
      //UPLOAD MEDIA
      String? imageUrl = compressionResult != null
          ? await CloudinaryService.uploadFile(
              compressionResult.file?.path ?? "",
              (count, total) {
                //CALCULATE PERCENTAGE
                double percentage = (count / total) * 100;
                uploadProgress.value = percentage;
                if (kDebugMode) {
                  log('Uploading image from file with progress: $percentage%');
                }
              },
            )
          : null;
      //ClEAR PROGRESS VALUES
      _clearProgressValues();
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
        _clearProgressValues();
        MediaInfo? compressedFilePath;
        //COMPRESS MEDIA
        if (postMedia.value.isNotEmpty) {
          compressedFilePath = await FileCompressor.compressVideoWithProgress(
            filePath: postMedia.value,
            onProgress: (progress) {
              compressionProgress.value = progress;
              if (kDebugMode) {
                log("COMPRESSING PROGRESS: $progress");
              }
            },
          );
        }
        compressionProgress.value = 0;
        uploadProgress.value = 1;
        if (kDebugMode && postMedia.value.isNotEmpty) {
          logFileSizes(postMedia.value, compressedFilePath?.file?.path);
        }
        //UPLOAD MEDIA
        imageUrl = compressedFilePath != null
            ? await CloudinaryService.uploadFile(
                compressedFilePath.file?.path ?? "",
                (count, total) {
                  //CALCULATE PERCENTAGE
                  double percentage = (count / total) * 100;
                  uploadProgress.value = percentage;
                  if (kDebugMode) {
                    log(
                      'Uploading image from file with progress: $percentage%',
                    );
                  }
                },
              )
            : null;
        //ClEAR PROGRESS VALUES
        _clearProgressValues();
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

  void _clearProgressValues() {
    compressionProgress.value = 0;
    uploadProgress.value = 0;
  }

  Future<void> getData(PostModel post) async {
    postDescription.text = post.description;
    postMediaUrl.value = post.mediaUrl ?? "";
  }

  void logFileSizes(String originalPath, String? compressedPath) {
    final originalSizeInMB = (File(originalPath).lengthSync() / (1024 * 1024))
        .toStringAsFixed(2);

    final compressedSizeInMB =
        compressedPath != null && compressedPath.isNotEmpty
        ? (File(compressedPath).lengthSync() / (1024 * 1024)).toStringAsFixed(2)
        : "0.00";

    log("ORIGINAL FILE SIZE: $originalSizeInMB MB");
    log("COMPRESSED FILE SIZE: $compressedSizeInMB MB");
  }
}
