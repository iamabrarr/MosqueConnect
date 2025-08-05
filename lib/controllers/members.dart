import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:mosqueconnect/views/widgets/custom_snackbar.dart';

class MembersController extends GetxController {
  Future<void> deleteMember(BuildContext context, String memberId) async {
    try {
      await firestore.collection(DbCollections.users).doc(memberId).delete();
      Get.back();
      showCustomSnackbar(context, false, "Member deleted successfully");
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      showCustomSnackbar(context, true, "Something went wrong");
    }
  }
}
