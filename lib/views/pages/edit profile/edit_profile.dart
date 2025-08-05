import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/constants/colors.dart';
import 'package:mosqueconnect/controllers/edit_profile.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: CustomAppbar(title: "Edit Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacing.y(3),
            Obx(
              () => GestureDetector(
                onTap: () => controller.pickImage(),
                child: Container(
                  height: SizeConfig.heightMultiplier * 8,
                  width: SizeConfig.widthMultiplier * 20,

                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(18),
                    image: controller.pickedImage.value.isNotEmpty
                        ? DecorationImage(
                            image: FileImage(
                              File(controller.pickedImage.value),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                    border: Border.all(color: AppColors.unFocusGreyClr),
                  ),
                  child: controller.pickedImage.value.isNotEmpty
                      ? null
                      : Icon(HugeIcons.strokeRoundedCamera01),
                ),
              ),
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Mosque's Name",
              controller: controller.mosqueNameController,
              keyboardType: TextInputType.name,
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Email Address",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            Spacing.y(4),
            CustomButton(onPressed: () {}, text: "Update"),
          ],
        ),
      ),
    );
  }
}
