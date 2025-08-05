import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/controllers/forgot_password.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(ForgotPasswordController());
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
            Text("Forgot Your Password? 🔒", style: textTheme.headlineSmall),
            Text(
              "Don’t worry! Enter your email to receive a link and reset your password securely.",
              style: textTheme.bodySmall!,
            ),
            Spacing.y(5),
            CustomTextField(
              label: "Email Address",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            Spacing.y(3),
            CustomButton(
              text: "Reset Password",
              isLoading: false,
              onPressed: () => controller.sendResetPasswordEmail(),
            ),

            Spacing.y(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember your password?",
                  style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () => Get.back(),
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
