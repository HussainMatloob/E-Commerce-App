import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Screens/admin_screens/add_new_product_screen.dart';
import 'package:e_commerce_app/models/user_profile.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/widgets/reuseable_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            StreamBuilder(
              stream: ServicesOrApis.fireStore
                  .collection('CartUser')
                  .where('id', isEqualTo: ServicesOrApis.user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final data = snapshot.data?.data();
                  final data = snapshot.data?.docs;
                  if (data != null) {
                    // final list = UserProfile.fromJson(data);
                    final list = data
                        .map((e) => UserProfile.fromJson(e.data()))
                        .toList() ??
                        [];
                            return Container(
                              padding:
                              EdgeInsets.only(bottom: mq.height * 0.02),
                              height: mq.height * 0.15,
                              width: mq.width * 0.9999,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 15, 141, 6)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: mq.width * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        width: mq.width * .199,
                                        height: mq.height * .1,
                                        fit: BoxFit.cover,
                                        imageUrl: list[0].image ?? "",
                                        // placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url,
                                            error) =>
                                            CircleAvatar(
                                                child: Icon(
                                                    CupertinoIcons.person)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * 0.03,
                                  ),
                                  Text(
                                    list[0].userName.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),

            InkWell(
              onTap: (){

              },
              child: Container(
                height: mq.height*0.12,
                width: mq.width*0.999,
                decoration: BoxDecoration(
                  color: Color(0XFFF1F8E9)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mq.height*0.01,),
                    Text("Earning",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),
                    Text("PKR "+"12,2433",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),
                  ],),
              ),
            ),
            SizedBox(height: mq.height*0.01,),
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewProduct()));
              },
              child: Container(
                height: mq.height*0.12,
                width: mq.width*0.999,
                decoration: BoxDecoration(
                    color: Color(0XFFF1F8E9)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: mq.height*0.035,),
                    Text("Add new product",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),
                  ],),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReuseableContainer(differentIcons: Icon(Icons.group,color: Colors.grey,size: 28,), text: "Users",
                countValue: "7", containerColor: Color(0xFFC5E1A5), onTap:(){

                }),

                ReuseableContainer(differentIcons: Icon(Icons.category,color: Colors.grey,size: 28,), text: "Categories",
                    countValue: "3", containerColor: Color(0xFFC5E1A5), onTap:(){

                    })

            ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReuseableContainer(differentIcons: Icon(Icons.production_quantity_limits,color: Colors.grey,size: 28,), text: "All Products",
                    countValue: "700", containerColor: Color(0xFFC5E1A5), onTap:(){

                    }),

                ReuseableContainer(differentIcons: Icon(Icons.shopping_cart,color: Colors.grey,size: 28,), text: "Orders",
                    countValue: "9", containerColor: Color(0xFFC5E1A5), onTap:(){

                    })

              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReuseableContainer(differentIcons: Icon(Icons.keyboard_return_sharp,color: Colors.grey,size: 28,), text: "Returns",
                    countValue: "10", containerColor: Color(0xFFC5E1A5), onTap:(){

                    }),

              ],),

          ],
        ),
      ),
    );
  }
}
