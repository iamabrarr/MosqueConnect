import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mosqueconnect/bindings/initial_bindings.dart';
import 'package:mosqueconnect/constants/app_data.dart';
import 'package:mosqueconnect/services/local_notification.dart';
import 'package:mosqueconnect/utils/theme.dart';
import 'package:mosqueconnect/utils/size_config.dart';
import 'package:mosqueconnect/views/pages/splash/splash.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await Permission.notification.request();
  LocalNotificationsService().initializeLocalNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotificationsService().showLocalNotification(message);
  });
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
            initialBinding: InitialBindings(),
            theme: AppTheme.primaryTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
