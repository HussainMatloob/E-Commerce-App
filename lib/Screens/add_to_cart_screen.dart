import 'package:e_commerce_app/Screens/payment_method_screen.dart';
import 'package:e_commerce_app/Screens/photo_view_screen.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_login_page.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/add_to_cart_controller.dart';
import '../main.dart';
import '../services/services.dart';
import '../widgets/reuseable_badge.dart';

class AddToCart extends StatefulWidget {
  ProductDetails productDetails;
  AddToCart({super.key, required this.productDetails});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetBuilder<AddToCartController>(
      init: AddToCartController(),
      builder: (addToCartController) {
        return Scaffold(
          backgroundColor: Color(0XFFD6D6D6),
          appBar: AppBar(
            actions: [
              ReuseableBadge(),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoViewer(
                                productDetails: widget.productDetails)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(mq.width * 0.02),
                    height: mq.height * 0.5,
                    width: mq.width * 0.999,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.productDetails.image.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.01,
                ),
                Container(
                  child: Center(
                    child: Text(
                      widget.productDetails.productName.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.01,
                ),
                Container(
                    padding: EdgeInsets.all(mq.width * 0.02),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productDetails.details.toString(),
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: mq.width*0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar.builder(
                                  itemSize: 25,
                                  initialRating: 3,
                                  minRating: 2,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                GetBuilder<Util>(
                                  init: Util(),
                                  builder: (util){
                                    return Container(
                                      child: InkWell(
                                        onTap: (){
                                          util.favouriteUpdate();
                                        },
                                        child: util.favourite? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ):Icon(Icons.favorite_border)
                                      ),
                                    );
                                  },
                                ),
                              ],
                              ),
                          ),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                                Container(
                                  padding: EdgeInsets.only(left: mq.width*0.02),
                                  child: Text(
                                    "Rs. " + widget.productDetails.price.toString(),
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(
                            height: mq.height * 0.03,
                          ),
                        ])),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                if(ServicesOrApis.user != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod()));
                }
                else{
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuyerLoginPage()));
                }
                      },
                      child: Container(
                        height: mq.height*0.06,
                        width: mq.width*0.28,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text("Buy Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    SizedBox(
                      width: mq.width * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        if (ServicesOrApis.user != null) {
                          ServicesOrApis.addProductToCart(widget.productDetails)
                              .then((value) {
                            if (value == true) {
                              addToCartController.addCounter();
                              addToCartController
                                  .addTotal(widget.productDetails.price!);
                              Get.snackbar(
                                'Success',
                                'Add Item successfully',
                                colorText: Colors.black,
                                backgroundColor: Colors.white24,
                                snackPosition: SnackPosition.TOP,
                                onTap: (SnackBar) {},
                              );
                            }
                          });
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyerLoginPage()));
                        }
                      },
                      child: Container(
                        height: mq.height*0.06,
                        width: mq.width*0.28,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
