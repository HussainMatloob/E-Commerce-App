import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../main.dart';
import '../models/cart_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with TickerProviderStateMixin{
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 1), vsync: this)
    ..repeat();
  List<CartModel> list = [];
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders"),),
     body: Column(
       children: [
         Expanded(
           child: StreamBuilder(
               stream: ServicesOrApis.getCartOrderItems(),
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
                               child: Container(
                                     child: Row(
                                       children: [
                                         Container(
                                           margin:
                                           EdgeInsets.all(mq.width * 0.02),
                                           height: mq.height * 0.11,
                                           width: mq.width * 0.24,
                                           decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(5),
                                               image: DecorationImage(
                                                 fit: BoxFit.fill,
                                                 image: NetworkImage(
                                                     list[index].image),
                                               )),
                                         ),
                                           Expanded(
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               children: [
                                                 Text(
                                                         list[index]
                                                             .productName
                                                             .toString(),
                                                     style: TextStyle(
                                                         fontWeight:
                                                         FontWeight.bold)),
                                                 SizedBox(height: mq.height*0.015,),

                                                 Text("Pending",style: TextStyle(
                                                         fontWeight:
                                                         FontWeight.bold,color: Colors.green)),
                                                 SizedBox(height: mq.height*0.005,),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                   children: [
                                                     Text(
                                                         "Quantity:"+
                                                             list[index]
                                                                 .quantity
                                                                 .toString(),
                                                         style: TextStyle(
                                                             fontWeight:
                                                             FontWeight.bold)),

                                                     Container(
                                                       padding: EdgeInsets.only(right: mq.width*0.1),
                                                       child: Text(
                                                           "Total:"+
                                                               list[index]
                                                                   .totalPrice
                                                                   .toString(),
                                                           style: TextStyle(
                                                               fontWeight:
                                                               FontWeight.bold)),
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ),

                                       ],
                                     ),
                                   ),
                                );
                         });
                   } else {
                     return Center(
                         child: Text(
                           "You Have No Any Order",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               fontSize: 18, fontWeight: FontWeight.bold),
                         ));
                   }
                 } else {
                   return Center(
                     child: SpinKitFadingCircle(
                       color: Colors.grey,
                       size: 100,
                       controller: _controller,
                     ),
                   );
                 }
               }),
         ),
       ],
     ),
    );
  }
}
