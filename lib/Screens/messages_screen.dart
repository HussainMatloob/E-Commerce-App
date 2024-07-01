import 'dart:convert';

import 'package:e_commerce_app/controller/get_device_token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
 final NotificationService notificationService=Get.put(NotificationService());
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),

        body: InkWell(
          onTap: () async{

            if(notificationService.deviceToken!=null) {
              print("Your token received");
              var data={
                //This is Receiver Device token
                'to':notificationService.deviceToken,
                'priority':'high',
                'notification':{
                  'title':'Easy Shopping',
                  'body':'Sale 50 percent off'
                },
                //Manage screen navigation after click on notification
                'data':{
                  'type':'msg',
                  'id':'hussain12354'
                }
              };
              await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              body: jsonEncode(data),
                headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                  //This is Server key
                  'Authorization' : 'key= Past Server key'
                }
              );
            }
          },
          child: Container(
            child: Center(child: Text("No Any Chats",textAlign: TextAlign.center,),),
          ),
        ),
      );

  }
}
