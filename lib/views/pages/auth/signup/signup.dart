import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mosqueconnect/controllers/signup.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/auth/login/login.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(title: ""),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacing.y(2),
            Image.asset(
              Assets.icons.appLogoWithoutText.path,
              height: SizeConfig.heightMultiplier * 10,
            ),
            Text("Register Your Mosque!🙌", style: textTheme.headlineSmall),
            Text(
              "Log in to view your mosque’s latest messages and videos.",
              style: textTheme.bodySmall!,
            ),
            Spacing.y(2),
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
            Spacing.y(2),
            CustomTextField(
              label: "Password",
              controller: controller.passwordController,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            Spacing.y(2),
            CustomTextField(
              label: "Confirm Password",
              controller: controller.confirmPasswordController,
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
            ),

            Spacing.y(3),
            CustomButton(
              text: "Create Account",
              isLoading: false,
              onPressed: () {},
            ),

            Spacing.y(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.to(() => LoginScreen());
                  },
                  child: Text(
                    "Login",
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
