import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/search_screen.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/widgets/reuseable_gridview_widget.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/reuseable_badge.dart';
import '../widgets/shimer_effect-weidget.dart';

class SalesProductScreen extends StatefulWidget {
  const SalesProductScreen({super.key});
  
  @override
  State<SalesProductScreen> createState() => _SalesProductState();
}

class _SalesProductState extends State<SalesProductScreen> {
  @override
  List<ProductDetails> details=[];
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Flash Sales"),
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
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('EasyShoppingProducts').where('sale',isEqualTo: "Sale").snapshots(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!.docs;
          if(data!=null){
            details = data
                ?.map((e) =>ProductDetails.fromJson(e.data()))
                .toList() ??
                [];
            return GridViewWidget(details: details);
          }
          else{
            return Center(child: Text("No Any Data"),);
          }
        }
        else{
          return ShimmerEffectWidget();
        }
      },)
    );
  }
}
