import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../main.dart';
import '../custom_widgets/reuseable_badge.dart';
import '../custom_widgets/reuseable_gridview_widget.dart';

class SalesProductScreen extends StatefulWidget {
  const SalesProductScreen({super.key});
  
  @override
  State<SalesProductScreen> createState() => _SalesProductState();
}

class _SalesProductState extends State<SalesProductScreen> {
  @override
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
      body:PaginateFirestore(itemBuilder: (context,documentSnapshot,index){
        ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
        return GridViewWidget(details: productDetails);
      }, query: ServicesOrApis.getSalesProducts(),
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
