import 'dart:io';
import 'dart:math';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

  class NotificationService extends GetxController {
    final Util util=Get.put(Util());
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    String? deviceToken;

    @override
    void onInit() {
      super.onInit();
      getDeviceToken();
      requestNotificationPermission();
     // initLocalNotification();
      //firebaseInIt();
    }

    void initLocalNotification(BuildContext context,RemoteMessage message) async {
      var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitialization = const DarwinInitializationSettings();
      var initializationSetting = InitializationSettings(
        android: androidInitialization,
        iOS: iosInitialization,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        },
      );
    }

    void firebaseInIt(BuildContext context) {
      FirebaseMessaging.onMessage.listen((message) {
        if (kDebugMode) {
          print(message.notification?.title.toString());
          print(message.notification?.body.toString());
          print(message.data.toString());
          print(message.data['type'].toString());
          print(message.data['id'].toString());
        }
        if(Platform.isAndroid){
          //The initLocalNotification function run when click in notification also app currently open
          initLocalNotification(context,message);
          showNotification(message);
        }
        else{
          showNotification(message);
        }
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
          channel.id.toString(),
          channel.name.toString(),
          channelDescription: 'Your Channel description',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          ticker: 'ticker',
          sound: channel.sound
        );

        // For iOS
        DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
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


//Click on notification When app in background or terminated then run setupInteractionMessage function
    Future<void> setupInteractionMessage(BuildContext context) async{
      //When app is Terminated
     RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
     if(initialMessage!=null){
       handleMessage(context, initialMessage);
     }
     // When app is is background
      FirebaseMessaging.onMessageOpenedApp.listen((event){
       handleMessage(context, event);
     });
    }

    void handleMessage(BuildContext context,RemoteMessage message){
     if(message.data['type']=='msg'){
         util.bottomNavIndex(1);
     }
    }
  }