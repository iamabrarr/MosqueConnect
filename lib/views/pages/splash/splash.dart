import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mosqueconnect/constants/controllers.dart';
import 'package:mosqueconnect/gen/assets.gen.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/views/animations/popup_animation.dart';
import 'package:mosqueconnect/views/pages/auth/onboarding/onboarding.dart';
import 'package:mosqueconnect/views/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => authController.initialRoot());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupAnimation(
          delay: 100,
          child: Image.asset(
            Assets.icons.appLogo.path,
            height: SizeConfig.heightMultiplier * 20,
          ),
        ),
      ),
    );
  }
}
