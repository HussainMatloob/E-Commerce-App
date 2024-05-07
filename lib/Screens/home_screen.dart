import 'package:e_commerce_app/widgets/reuseable_badge.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'home_categories_view.dart';
import 'home_top_view.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            child: Text("Shopping Cart",style: TextStyle(
                fontSize: 25,
                fontFamily: 'BerkshireSwash Regular',
                color: Colors.green),),
          ),
          actions: [
                      Icon(
                        Icons.search,
                        size: 27,
                      ),
            SizedBox(width: mq.width*0.05,),
            ReuseableBadge(),
            SizedBox(width: mq.width*0.08,),
          ]),

      body: SingleChildScrollView(
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
