import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/models/post.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class HomeController extends GetxController {
  Future<void> deletePost(BuildContext context, String postID) async {
    try {
      await firestore
          .collection(DbCollections.mosquePosts)
          .doc(postID)
          .delete();
      Get.back();
      showCustomSnackbar(context, false, "Post deleted successfully");
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }

      showCustomSnackbar(context, true, "Something went wrong");
    }
  }

  Future<void> changeStatusPost(
    BuildContext context,
    String postID,
    bool status,
  ) async {
    try {
      await firestore.collection(DbCollections.mosquePosts).doc(postID).update({
        "isActive": !status,
      });
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<void> addViewer(PostModel post) async {
    if (post.createdBy != authController.currentUser?.uid) {
      await firestore.collection(DbCollections.mosquePosts).doc(post.id).update(
        {
          "viewers": FieldValue.arrayUnion([
            authController.currentUser?.uid ?? "",
          ]),
        },
      );
    }
  }
}
