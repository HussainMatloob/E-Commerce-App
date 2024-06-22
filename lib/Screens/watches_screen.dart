import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';

import '../widgets/reuseable_gridview_widget.dart';
import '../widgets/shimer_effect-weidget.dart';
class WatchesScreen extends StatefulWidget {
  const WatchesScreen({super.key});

  @override
  State<WatchesScreen> createState() => _WatchesScreenState();
}

class _WatchesScreenState extends State<WatchesScreen> {
  @override
  List<ProductDetails> details=[];
  Widget build(BuildContext context) {
    return Scaffold(
        body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('EasyShoppingProducts').where('type',isEqualTo: "Watches").snapshots(),
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
