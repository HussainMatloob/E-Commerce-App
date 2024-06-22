import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/product_details.dart';
import '../widgets/reuseable_badge.dart';
import '../widgets/shimer_effect-weidget.dart';
import 'add_to_cart_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  List<ProductDetails> details=[];
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("All products"),
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
          ]
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('EasyShoppingProducts').where('sale',isNotEqualTo: "Sale").snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            final data = snapshot.data!.docs;
            if(data!=null){
              details = data
                  ?.map((e) =>ProductDetails.fromJson(e.data()))
                  .toList() ??
                  [];
              return  GridView.builder(
                physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                ),
                itemCount: details.length, // Use actual item count
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(mq.width * 0.02),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails: details[index],)));
                          },
                          child: Container(
                            padding: EdgeInsets.only( bottom:mq.width*0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: mq.height * 0.17,
                                width: mq.width * 0.5,
                                imageUrl:
                                details[index].image![0]
                                    .toString(),
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Center(

                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            details[index].productName
                                .toString(),overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),),
                        details[index].sale=="Sale"? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("Rs:"+

                                  details[index].salePrice
                                      .toString(),
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),),
                            SizedBox(width: mq.width*0.01,),
                            Center(
                              child: Text(
                                details[index].price
                                    .toString(),
                                style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough),
                                textAlign: TextAlign.center,
                              ),),
                          ],):Center(
                          child: Text("Rs:"+
                              details[index].price
                                  .toString(),overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),),
                      ],
                    ),
                  );
                },
              );
            }
            else{
              return Center(child: Text("No Any Data"),);
            }
          }
          else{
            return ShimmerEffectWidget();
          }
        },),
    );
  }
}
