import 'package:e_commerce_app/Screens/just_for_you_screen.dart';
import 'package:e_commerce_app/Screens/watches_screen.dart';
import 'package:e_commerce_app/Screens/mens_fashion_screen.dart';
import 'package:e_commerce_app/Screens/womens_fashion_screen.dart';
import 'package:e_commerce_app/widgets/reuseable_badge.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import '../main.dart';
class CategoriesButtonsTabbar extends StatefulWidget {
  const CategoriesButtonsTabbar({super.key});

  @override
  State<CategoriesButtonsTabbar> createState() => _CategoriesButtonsTabbarState();
}

class _CategoriesButtonsTabbarState extends State<CategoriesButtonsTabbar> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Just for you"),
        actions: [
          Icon(Icons.search),
          SizedBox(
            width: mq.width * 0.02,
          ),
          ReuseableBadge(),
          SizedBox(width: 20,),
          Icon(Icons.more_vert),
          SizedBox(
            width: mq.width * 0.02,
          ),
        ],
      ),
      body:DefaultTabController(
        length: 4,
        child: Column(
          children:[
            ButtonsTabBar(
              // Customize the appearance and behavior of the tab bar
              backgroundColor: Colors.green,
              borderWidth: 2,
              borderColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              // Add your tabs here
              tabs:[
                Tab(text: "Just For You",),
                Tab(text: "Watches",),
                Tab(text: "Men's Fashion"),
                Tab(text: "Women's Fashion"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  JustForYou(),
                  WatchesScreen(),
                  MensFashion(),
                  WomensFashion(),
                ],
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}
