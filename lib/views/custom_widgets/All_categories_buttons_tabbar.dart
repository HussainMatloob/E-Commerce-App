import 'package:e_commerce_app/views/custom_widgets/reuseable_badge.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../main.dart';
import '../screens/man_shoes_screen.dart';
import '../screens/mens_fashion_screen.dart';
import '../screens/search_screen.dart';
import '../screens/watches_screen.dart';
import '../screens/womens_fashion_screen.dart';

class AllCategoriesButtonsTabbar extends StatefulWidget {
  const AllCategoriesButtonsTabbar({super.key});

  @override
  State<AllCategoriesButtonsTabbar> createState() =>
      _AllCategoriesButtonsTabbarState();
}

class _AllCategoriesButtonsTabbarState
    extends State<AllCategoriesButtonsTabbar> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Icon(Icons.search)),
          SizedBox(
            width: mq.width * 0.02,
          ),
          ReuseableBadge(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
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
              tabs: [
                Tab(text: "Women's Fashion"),
                Tab(text: "Men's Fashion"),
                Tab(
                  text: "Watches",
                ),
                Tab(
                  text: "Man Shoes",
                ),
              ],
            ),
            // Expanded(
            //   child: TabBarView(
            //     children: [
            //       WomensFashion(),
            //       MensFashion(),
            //       WatchesScreen(),
            //       ManShoesScreen(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
