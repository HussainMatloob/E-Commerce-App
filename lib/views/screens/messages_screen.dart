import 'package:e_commerce_app/controller/get_device_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final NotificationService notificationService =
      Get.put(NotificationService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Text("No any chat"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.emoji_emotions),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Text", border: InputBorder.none),
                              ),
                            ),
                            Icon(Icons.image),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.camera_alt),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (notificationService.deviceToken != null) {
                        Notifications.sendNotificationToSelectedDevice(
                            "cH0c30PZRXaf0GKFmrFnT-:APA91bGTLPPh1w2Lrsr-Tr5L3PLTO1Nb2IJBkf8ngErvM3yZwX69zn0yLH1rY6O3D0J-cvzKGwRRuUm7wqYYG-SMqbfMUQ-RONv9DxxBKv-J1qpqWDix1cKKGPVg3M5GhFxF-2K_fx5h",
                            context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Icon(Icons.send),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ));
  }
}
