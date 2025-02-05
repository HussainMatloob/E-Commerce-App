import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../models/product_details.dart';
import '../../services/services.dart';
import '../custom_widgets/reuseable_gridview_widget.dart';

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
        body:PaginateFirestore(itemBuilder: (context,documentSnapshot,index){
          ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
          return GridViewWidget(details: productDetails);
        }, query: ServicesOrApis. getWomenFashion(),
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
