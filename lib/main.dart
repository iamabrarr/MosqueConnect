import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mosqueconnect/constants/app_data.dart';
import 'package:mosqueconnect/utils/theme.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/views/pages/splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return LayoutBuilder(
      builder: (context, constraints) => OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: AppTheme.primaryTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
