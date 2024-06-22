import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';

import '../Screens/add_to_cart_screen.dart';
import '../main.dart';

class GridViewWidget extends StatefulWidget {
  List<ProductDetails> details;
   GridViewWidget({super.key,required this.details});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                     shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,

                    ),
                    itemCount: widget.details.length, // Use actual item count
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(mq.width * 0.02),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails: widget.details[index],)));
                              },
                              child: Container(
                                padding: EdgeInsets.only( bottom:mq.width*0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: mq.height * 0.17,
                                    width: mq.width * 0.5,
                                    imageUrl:
                                    widget.details[index].image![0]
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
                                widget.details[index].productName
                                    .toString(),overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),),
                            widget.details[index].sale=="Sale"? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("Rs:"+

                                          widget.details[index].salePrice
                                          .toString(),
                                    style: TextStyle(fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),),
                                SizedBox(width: mq.width*0.01,),
                                Center(
                                  child: Text(
                                     widget.details[index].price
                                        .toString(),
                                    style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough),
                                    textAlign: TextAlign.center,
                                  ),),
                              ],):Center(
                      child: Text("Rs:"+
                          widget.details[index].price
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
}
