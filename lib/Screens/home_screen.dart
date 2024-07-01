
import 'package:e_commerce_app/Screens/home_categories_view.dart';
import 'package:e_commerce_app/Screens/search_screen.dart';
import 'package:e_commerce_app/widgets/reuseable_badge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/get_device_token_controller.dart';
import '../main.dart';
import 'home_top_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {
@override
final NotificationService notificationService=Get.put(NotificationService());
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.setupInteractionMessage(context);
    notificationService.firebaseInIt(context);
    //deviceTokenAndNotificationPermissionController.isTokenRefresh();
    print(notificationService.deviceToken);

  }
  @override

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          //backgroundColor: Colors.grey,
          leading:
                Icon(
                  Icons.qr_code,
                  size: 27,
                ),

          title: Container(

            padding: EdgeInsets.only(left: mq.width * 0.03),
            height: mq.height * 0.05,

            decoration: BoxDecoration(
                ),
            child: Text("Easy Shopping",style: TextStyle(
                fontSize: 25,
                fontFamily: 'BerkshireSwash Regular',
                color: Colors.green),),
          ),
          actions: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        },
                        child: Icon(
                          Icons.search,
                          size: 27,
                        ),
                      ),
            SizedBox(width: mq.width*0.05,),
            ReuseableBadge(),
            SizedBox(width: mq.width*0.08,),
          ]),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HomeTopView(),
            HomeCategoriesView(),
          ],
        ),
      ),
    );
  }

}
