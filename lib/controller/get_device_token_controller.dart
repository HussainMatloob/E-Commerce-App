  import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

  class NotificationService extends GetxController {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    String? deviceToken;

    @override
    void onInit() {
      super.onInit();
      getDeviceToken();
      requestNotificationPermission();
      initLocalNotification();
      firebaseInIt();
    }

    void initLocalNotification() async {
      var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitialization = const DarwinInitializationSettings();
      var initializationSetting = InitializationSettings(
        android: androidInitialization,
        iOS: iosInitialization,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          // Handle notification response
        },
      );
    }

    void firebaseInIt() {
      FirebaseMessaging.onMessage.listen((message) {
        if (kDebugMode) {
          print(message.notification?.title.toString());
          print(message.notification?.body.toString());
        }
        showNotification(message);
      });
    }

    Future<void> showNotification(RemoteMessage message) async {
      try {
        AndroidNotificationChannel channel = AndroidNotificationChannel(
          Random.secure().nextInt(100000).toString(),
          "Important Notifications",
          importance: Importance.max,
        );

        // For Android
        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: 'Your Channel description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );

        // For iOS
        DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
          presentSound: true,
          presentBadge: true,
          presentAlert: true,
        );

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: darwinNotificationDetails,
        );

        await _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          notificationDetails,
        );
      } catch (e) {
        if (kDebugMode) {
          print('Error showing notification: $e');
        }
      }
    }

    void requestNotificationPermission() async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("User granted Permission");
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print("User provisional Permission");
      } else {
        print("User denied Permission");
      }
    }

    Future<void> getDeviceToken() async {
      try {
        String? token = await messaging.getToken();
        if (token != null) {
          deviceToken = token;
          update();
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Token Not Generated',
          colorText: Colors.black,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          onTap: (SnackBar) {},
        );
      }
    }

    Future<void> isTokenRefresh() async {
      try {
        messaging.onTokenRefresh.listen((event) {
          print('Token refreshed: $event');
        });
      } catch (e) {
        Get.snackbar(
          'Error',
          'Token Not Refreshed',
          colorText: Colors.black,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          onTap: (SnackBar) {},
        );
      }
    }
  }