//import 'dart:developer';
import 'package:e_commerce_app/Screens/payment_method_screen.dart';
import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:e_commerce_app/controller/add_to_cart_controller.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auths/Buyer_Account/buyer_login_page.dart';
import '../main.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 1), vsync: this)
    ..repeat();
  List<CartModel> list = [];
  @override
  String splitText(String text) {
    List<String> words = text.split(' ');
    List<String> lines = [];

    for (int i = 0; i < words.length; i += 2) {
      int end = i + 2;
      if (end > words.length) {
        end = words.length;
      }
      lines.add(words.sublist(i, end).join(' '));
    }

    return lines.join('\n');
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetBuilder<AddToCartController>(
      init: AddToCartController(),
      builder: (addToCartController) {
        return Scaffold(
          backgroundColor: Color(0XFFD6D6D6),
          appBar: AppBar(
            actions: [
              Center(
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  badgeContent: Text(
                      addToCartController.getCounterValue().toString(),
                      style: TextStyle(color: Colors.white)),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 2),
                    colorChangeAnimationDuration: Duration(seconds: 3),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                    //shape: badges.BadgeShape.square,
                    borderRadius: BorderRadius.circular(8),
                    //borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),

          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: ServicesOrApis.getCartItems(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!.docs;
                        if (data != null && data.isNotEmpty) {
                          list = data
                                  ?.map((e) => CartModel.fromJson(e.data()))
                                  .toList() ??
                              [];
                          return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.all(mq.width * 0.02),
                                            height: mq.height * 0.14,
                                            width: mq.width * 0.3,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      list[index].image),
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                splitText(
                                                    list[index].productName),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "Price:" +
                                                      list[index]
                                                          .totalPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                         InkWell(
                                           onTap: (){
                                             ServicesOrApis.DeleteItem(
                                                 list[index]);
                                             addToCartController.lessCounter();
                                             addToCartController.lessTotal(list[index].totalPrice);
                                           },
                                           child: Container(
                                             margin: EdgeInsets.only(right: mq.width*0.02),
                                             height: mq.height*0.05,
                                             width: mq.width*0.24,
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(100),
                                               border: Border.all(color: Colors.green,
                                               width: 1)
                                             ),
                                             child: Center(child: Text("Remove",style: TextStyle(fontWeight: FontWeight.bold),)),
                                           ),
                                         ),
                                        SizedBox(
                                          height: mq.height * 0.01,
                                        ),
                                        Container(
                                          height: mq.height * 0.05,
                                          width: mq.width * 0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),

                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [

                                               InkWell(
                                                 onTap: (){
                                                   if (int.parse(list[index]
                                                       .quantity) !=
                                                       1) {
                                                     int lessprice = list[index]
                                                         .initialPrice;
                                                     lessprice = -lessprice +
                                                         list[index].totalPrice;
                                                     int lessQuantity =
                                                     int.parse(list[index]
                                                         .quantity);
                                                     lessQuantity--;
                                                     ServicesOrApis
                                                         .lessItemQuantity(
                                                         list[index],
                                                         lessprice,
                                                         lessQuantity);
                                                     addToCartController.lessTotal(list[index].initialPrice);
                                                   }
                                                 },
                                                 child: Container(
                                                   height: mq.height*0.03,
                                                   width: mq.width*0.06,
                                                   decoration: BoxDecoration(
                                                       color: Colors.green,
                                                       border:Border.all(color: Colors.black,
                                                         width: 1,
                                                       ),
                                                     borderRadius: BorderRadius.circular(3),
                                                   ),
                                                   child: Center(
                                                     child: Icon(
                                                       Icons.remove,size: 20,
                                                       color: Colors.white,
                                                     ),
                                                   ),
                                                 ),
                                               ),

                                              Text(
                                                list[index].quantity,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                                GestureDetector(
                                                  onTap:(){
                                                    int addprice =
                                                        list[index].initialPrice;
                                                    addprice +=
                                                        list[index].totalPrice;
                                                    int addQuantity = int.parse(
                                                        list[index].quantity);
                                                    addQuantity++;
                                                    ServicesOrApis
                                                        .addItemQuantity(
                                                        list[index],
                                                        addprice,
                                                        addQuantity);
                                                    addToCartController.addTotal(list[index].initialPrice);
                                                 },
                                                  child: Container(
                                                    height: mq.height*0.03,
                                                    width: mq.width*0.06,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      border:Border.all(color: Colors.black,
                                                      width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(3),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.add,size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                              });
                        } else {
                          return Center(
                              child: Text(
                            "No Any Item\nAdded",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ));
                        }
                      } else {
                        return Expanded(
                            flex: 1,
                            child: Center(
                              child: SpinKitFadingCircle(
                                color: Colors.grey,
                                size: 100,
                                controller: _controller,
                              ),
                            ));
                      }
                    }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: mq.width*0.03),
                margin: EdgeInsets.symmetric(horizontal: mq.width*0.02),
                height: mq.height*0.08,
                width: mq.width*0.999,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Container(
                     child: Row(children: [
                       Icon(Icons.shopping_basket,color: Colors.white60,),
                       SizedBox(width: mq.width*0.01,),
                       Text("Total: Rs."+addToCartController.getTotal().toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white,),),
                     ],),
                   ),
                  InkWell(
                    onTap: () async{
                      // SharedPreferences sp=await SharedPreferences.getInstance();
                      // sp.remove('count');
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
                      height: mq.height*0.05,
                      width: mq.width*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red),
                      child: Center(child: Text("Buy Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                    ),
                  ),

                ],),

              ),
            ],
          ),
        );
      },
    );
  }
}
