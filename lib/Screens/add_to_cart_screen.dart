import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Screens/payment_method_screen.dart';
import 'package:e_commerce_app/Screens/photo_view_screen.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_login_page.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
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

class _AddToCartState extends State<AddToCart> with TickerProviderStateMixin{
  late final AnimationController _controllerAnimate =
  AnimationController(duration: const Duration(seconds: 1), vsync: this)
    ..repeat();
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
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                  child: Padding(
                    padding: EdgeInsets.all(mq.width * 0.01),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40)),
                     child:  CachedNetworkImage(
                       height: mq.height * 0.5,
                       width: mq.width * 0.999,
                        imageUrl: widget.productDetails.image![0]
                            .toString(),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 50,
                            controller: _controllerAnimate,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
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
                          widget.productDetails.sale=='Sale'? Row(

                            children: [
                              SizedBox(
                                width: mq.width * 0.02,
                              ),
                               Text("Rs:"+

                                    widget.productDetails.salePrice
                                        .toString(),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              SizedBox(width: mq.width*0.01,),
                               Text(
                                  widget.productDetails.price
                                      .toString(),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),
                                  textAlign: TextAlign.center,
                                ),
                            ],):Container(
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
                        if (ServicesOrApis.user != null) {
                          EasyLoading.instance
                            ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
                            ..textColor = Colors.white // Color of the loading status text
                            ..indicatorColor = Colors.white // Color of the loading indicator
                            ..progressColor = Colors.white // Progress color of the loading indicator (if applicable)
                            ..backgroundColor = Colors.green // Background color of the loading indicator
                            ..maskColor = Colors.red; // Mask color of the loading (if applicable)
                          EasyLoading.show(status: 'Please Wait...');
                          ServicesOrApis.addProductToCart(widget.productDetails)
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();

                              ServicesOrApis.addTotalAndCount(widget.productDetails);
                              Get.snackbar(
                                'Success',
                                'Add Item successfully',
                                colorText: Colors.black,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                onTap: (SnackBar) {},
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod()));
                            }
                            else{
                              EasyLoading.dismiss();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod()));
                            }
                          }).onError((error, stackTrace){
                            EasyLoading.dismiss();
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

                          EasyLoading.instance
                            ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
                            ..textColor = Colors.white // Color of the loading status text
                            ..indicatorColor = Colors.white // Color of the loading indicator
                            ..progressColor = Colors.white // Progress color of the loading indicator (if applicable)
                            ..backgroundColor = Colors.green // Background color of the loading indicator
                            ..maskColor = Colors.red; // Mask color of the loading (if applicable)
                          EasyLoading.show(status: 'Please Wait...');

                          ServicesOrApis.addProductToCart(widget.productDetails)
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();

                              ServicesOrApis.addTotalAndCount(widget.productDetails);

                              Get.snackbar(
                                'Success',
                                'Add Item successfully',
                                colorText: Colors.black,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                onTap: (SnackBar) {},
                              );
                            }
                            else{
                              EasyLoading.dismiss();
                              Get.snackbar(
                                '',
                                'Check your Cart this item already added',
                                colorText: Colors.black,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                onTap: (SnackBar) {},
                              );
                            }
                          }).onError((error, stackTrace){
                            EasyLoading.dismiss();
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
                ),
                SizedBox(
                   height: mq.height*0.02),
              ],
            ),
          ),
        );
      },
    );
  }
}
