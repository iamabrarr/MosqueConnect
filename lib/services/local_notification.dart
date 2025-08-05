import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const channelID = 'high_importance_channel';

  //INITIALIZE LOCAL NOTIFICATIONS
  void initializeLocalNotifications() async {
    var androidInitialize = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitialize = const DarwinInitializationSettings();
    var initializeSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );
    flutterLocalNotificationsPlugin.initialize(initializeSettings);
    requestNotificationPermissions();
  }

  //PERMISSION FOR NOTIFICATIONS
  static Future<void> requestNotificationPermissions() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      channelID,
      channelID,
      playSound: true,
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  void showLocalNotification(RemoteMessage message) async {
    try {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        bool isImgNotification = false;
        String largeIconPath = '';
        String bigPicturePath = '';
        String? url;

        if (Platform.isAndroid) {
          url = message.notification?.android?.imageUrl;
        } else {
          url = message.notification?.apple?.imageUrl;
        }

        isImgNotification = url != null;
        BigPictureStyleInformation? bigPictureStyleInformation;
        // log(notification.apple?.imageUrl ?? "NOT IMAGE");
        if (isImgNotification) {
          final img = await loadImageAndConvertToBase64(url);
          bigPictureStyleInformation = BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(base64Encode(img)),
            hideExpandedLargeIcon: true,
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(img),
            ),
          );

          largeIconPath = await _downloadAndSaveFile(
            url,
            'largeIcon',
            Platform.isIOS,
          );
          bigPicturePath = await _downloadAndSaveFile(
            url,
            'bigPicture',
            Platform.isIOS,
          );
        }

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelID,
              channelID,
              icon: 'launch_background',
              channelDescription: 'App notifications',
              importance: Importance.max,
              priority: Priority.max,
              largeIcon:
                  url == null ? null : FilePathAndroidBitmap(largeIconPath),
              styleInformation: url == null ? null : bigPictureStyleInformation,
            ),
            // ignore: unnecessary_null_comparison
            iOS:
                url == null
                    ? const DarwinNotificationDetails()
                    : DarwinNotificationDetails(
                      attachments: [
                        DarwinNotificationAttachment(bigPicturePath),
                      ],
                    ),
          ),
        );
      } else {}
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }

  Future<List<int>> loadImageAndConvertToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    List<int> imageData = response.bodyBytes;
    return imageData;
  }

  Future<String> _downloadAndSaveFile(
    String url,
    String fileName,
    bool isIOS,
  ) async {
    final Directory? directory =
        isIOS
            ? await getApplicationDocumentsDirectory()
            : await getExternalStorageDirectory();
    final String filePath = '${directory!.path}/$fileName.png';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotificationTest(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      importance: Importance.max,
      priority: Priority.max,
    );
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationsDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    Random rand = Random();
    await flutterLocalNotificationsPlugin.show(
      rand.nextInt(999),
      title,
      body,
      generalNotificationsDetails,
    );
    // await flutterLocalNotificationsPlugin.cancel(7663135);
  }

  // Future<void> sendNotification(DateTime date, String orderID, String title,
  //     String body, bool isRepeatDaily) async {
  //   var androidDetails = const AndroidNotificationDetails(
  //       "channel_id", "channel_name",
  //       importance: Importance.max, priority: Priority.max);
  //   var iosDetails = const DarwinNotificationDetails();
  //   var generalNotificationsDetails =
  //       NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   int notifyID = Random().nextInt(9999);
  //   final updatedDate = tz.TZDateTime.from(
  //       date, tz.getLocation(authCont.defaultTimeZone.value));
  //   print("UPDATED DATE ${updatedDate}");
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     notifyID,
  //     title,
  //     body,
  //     updatedDate,
  //     generalNotificationsDetails,
  //     androidScheduleMode: AndroidScheduleMode.exact,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: isRepeatDaily
  //         ? DateTimeComponents.time
  //         : DateTimeComponents.dateAndTime,
  //   );
  //   //ADD IN FIREBASE
  //   await firestore.collection('scheduledTasks').add({
  //     'body': body,
  //     'title': title,
  //     'taskName': notifyID.toString(),
  //     'time': date.toString(),
  //     'orderId': orderID
  //   });
  // }

  Future<void> cancelOrderNotifications(int orderDocID) async {
    for (int i = 0; i < 5; i++) {
      int notifyID = orderDocID + i;
      await flutterLocalNotificationsPlugin.cancel(notifyID);
    }
  }

  Future<void> cancelNotification(int notifyID) async {
    await flutterLocalNotificationsPlugin.cancel(notifyID);
  }
}
