import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../main.dart';
import '../../services/services.dart';
import '../custom_widgets/reuseable_gridview_widget.dart';

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
        body:
        PaginateFirestore(itemBuilder: (context,documentSnapshot,index){
          ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
          return GridViewWidget(details: productDetails);
        }, query: ServicesOrApis. getManShoes(),
          itemBuilderType: PaginateBuilderType.gridView,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisExtent: 210
          ),
          onEmpty:Center(
              child: Text(
                "There is no any product!",
                style: TextStyle(fontSize:20),
              )),
        )
    );
  }
}