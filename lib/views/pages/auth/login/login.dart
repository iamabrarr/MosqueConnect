import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/controllers/login.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/auth/forgot%20password/forgot_password.dart';
import 'package:mosqueconnect/views/pages/auth/signup/signup.dart';
import 'package:mosqueconnect/views/widgets/bottom_nav_bar.dart';
import 'package:mosqueconnect/views/widgets/custom_appbar.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';
import 'package:mosqueconnect/views/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
            Text("Welcome back!✨", style: textTheme.headlineSmall),
            Text(
              "Log in to view your mosque’s latest messages and videos.",
              style: textTheme.bodySmall!,
            ),
            Spacing.y(5),
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
            Spacing.y(1),
            GestureDetector(
              onTap: () {
                Get.to(() => ForgotPasswordScreen());
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.textMultiplier * 1.3,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Spacing.y(3),
            Obx(
              () => CustomButton(
                text: "Log in",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.onLogin(context);
                },
              ),
            ),

            Spacing.y(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Text(
                    "Sign up",
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
