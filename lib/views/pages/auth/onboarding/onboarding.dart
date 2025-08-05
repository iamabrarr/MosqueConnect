import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/utils/spacing.dart';
import 'package:mosqueconnect/views/pages/auth/login/login.dart';
import 'package:mosqueconnect/views/pages/auth/signup/signup.dart';
import 'package:mosqueconnect/views/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.widthMultiplier * 100,
            color: Colors.black,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                Assets.images.onboarding.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.widthMultiplier * 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  Assets.icons.appLogoWithoutText.path,
                  color: Colors.white,
                  height: SizeConfig.heightMultiplier * 10,
                ),
                Text(
                  "Connect with Your Masjid",
                  style: textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
                Spacing.y(1),
                Text(
                  "Join your mosque online, watch sermons, read updates, and stay spiritually connected anytime.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Spacing.y(2),
                CustomButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  text: "Signup",
                ),
                Spacing.y(1.5),
                CustomButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  isBorder: true,
                  borderColor: Colors.white,
                  isShadow: false,
                  color: null,
                  text: "Login",
                ),

                Spacing.y(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
