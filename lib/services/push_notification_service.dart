import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class PushNotificationService {
  static String firebase = 'firebase';
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async{
      print("Nouveau token FCM : $newToken");
      await PushNotificationService.updateDeviceToken(newToken);
      // ➤ Envoie-le à ton backend pour mise à jour
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('App opened from notification: ${message.data['route']}');

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'channel_name',
              channelDescription: 'channel_description',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    // Background & terminated messages
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('App opened from notification: ${message.data['route']}');
    // });


  }

  static getDeviceToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token;
  }

  static Future<String?> initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Step 1: Request permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Step 2: Wait until APNs token is set
      String? apnsToken = await messaging.getAPNSToken();
      // print("APNs Token: $apnsToken");

      // Step 3: Now get the FCM token
      String? fcmToken = await messaging.getToken();
      // print("FCM Token: $fcmToken");
      return fcmToken;
    } else {
      print("User declined permission");
    }
    return null;
  }


  static Future updateDeviceToken(String deviceToken) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$firebase/${'update-device-token'}?token=$deviceToken');
      print(url);
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.post(
        url,
        headers: headers,
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }

  }
  static Future sendOtp(String deviceToken) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$firebase/${'send-otp'}?token=$deviceToken');
      print(url);
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.post(
        url,
        headers: headers,
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }

  }
}
