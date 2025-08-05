import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:mosqueconnect/constants/db_collections.dart';
import 'package:mosqueconnect/constants/instances.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  static String? _accessToken;
  static Future<void> sendPushNotification({
    required String userID,
    required String title,
    required String body,
  }) async {
    final userData = await firestore
        .collection(DbCollections.users)
        .doc(userID)
        .get();
    String? fcmToken = userData['fcmToken'];
    if (fcmToken != null) {
      _accessToken ??= await _getAccessToken();

      await http
          .post(
            Uri.parse(
              'https://fcm.googleapis.com/v1/projects/teenbeez/messages:send',
            ),
            headers: <String, String>{'Authorization': "Bearer $_accessToken"},
            body: jsonEncode(<String, dynamic>{
              "message": {
                "token": fcmToken,
                "notification": {"body": body, "title": title},
              },
            }),
          )
          .then((value) {
            print("Successfully Send ${value.body}");
          })
          .catchError((e) {
            log(e.toString());
          });
    }
  }

  static Future<String> _getAccessToken() async {
    // Load the service account key JSON file
    final serviceAccountJson = await rootBundle.loadString(
      'assets/keys/push_notification_key.json',
    );
    final serviceAccount = json.decode(serviceAccountJson);

    // Create the JWT client
    final accountCredentials = ServiceAccountCredentials.fromJson(
      serviceAccount,
    );
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Obtain an authenticated client
    final client = await clientViaServiceAccount(accountCredentials, scopes);

    // Access the auth credentials to get the access token
    final authHeaders = client.credentials.accessToken;
    log(authHeaders.data.toString());
    return authHeaders.data;
  }
}
