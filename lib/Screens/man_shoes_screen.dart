import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/add_to_cart_screen.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/product_detail_controller.dart';
import '../main.dart';
import '../widgets/reuseable_gridview_widget.dart';
import '../widgets/shimer_effect-weidget.dart';


class ManShoesScreen extends StatefulWidget {
  const ManShoesScreen({super.key});

  @override
  State<ManShoesScreen> createState() => _ManShoesScreenState();
}

class _ManShoesScreenState extends State<ManShoesScreen> {
  List<ProductDetails> details=[];
  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;
    return Scaffold(
        body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('EasyShoppingProducts').where('type',isEqualTo: "Man Shoes").snapshots(),
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