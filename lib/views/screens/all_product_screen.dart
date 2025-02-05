import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../main.dart';
import '../../models/product_details.dart';
import '../custom_widgets/reuseable_badge.dart';
import 'add_to_cart_screen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
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
      body: PaginateFirestore(itemBuilder: (context,documentSnapshot,index){
        ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
        //return ShimmerEffectWidget();
        return  Container(
              margin: EdgeInsets.all(mq.width * 0.02),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails: productDetails,)));
                    },
                    child: Container(
                      padding: EdgeInsets.only( bottom:mq.width*0.02),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: mq.height * 0.17,
                          width: mq.width * 0.5,
                          imageUrl:
                          productDetails.image![0]
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
                      productDetails.productName
                          .toString(),overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),),
                   productDetails.sale=="Sale"? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Rs:"+

                            productDetails.salePrice
                                .toString(),
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),),
                      SizedBox(width: mq.width*0.01,),
                      Center(
                        child: Text(
                          productDetails.price
                              .toString(),
                          style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.center,
                        ),),
                    ],):Center(
                    child: Text("Rs:"+
                        productDetails.price
                            .toString(),overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),),
                ],
              ),
            );

      },
          query: ServicesOrApis.getAllProducts(),
          //isLive: true,
          scrollDirection: Axis.vertical,
          itemBuilderType: PaginateBuilderType.gridView,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
            mainAxisExtent: 210// Set the number of columns you want
        ),
         onEmpty:Center(
             child: Text(
               "There is no any product!",
                style: TextStyle(fontSize:20),
             )),

      ),

    );
  }
}
