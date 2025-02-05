import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../services/services.dart';
import '../custom_widgets/reuseable_gridview_widget.dart';


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
        body:PaginateFirestore(itemBuilder: (context,documentSnapshot,index){
          ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
          return GridViewWidget(details: productDetails);
        }, query: ServicesOrApis. getWatches(),
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
