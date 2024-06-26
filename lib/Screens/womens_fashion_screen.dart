import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_details.dart';
import '../widgets/reuseable_gridview_widget.dart';
import '../widgets/shimer_effect-weidget.dart';

class WomensFashion extends StatefulWidget {
  const WomensFashion({super.key});

  @override
  State<WomensFashion> createState() => _WomensFashionState();
}

class _WomensFashionState extends State<WomensFashion> {
  @override
  List<ProductDetails> details=[];
  Widget build(BuildContext context) {
    return Scaffold(
        body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('EasyShoppingProducts').where('type',isEqualTo: "Women's Fashion").snapshots(),
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
