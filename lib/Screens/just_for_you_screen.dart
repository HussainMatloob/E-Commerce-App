import 'package:e_commerce_app/Screens/add_to_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_detail_controller.dart';
import '../main.dart';


class JustForYou extends StatefulWidget {
  const JustForYou({super.key});

  @override
  State<JustForYou> createState() => _JustForYouState();
}

class _JustForYouState extends State<JustForYou> {
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
    return Scaffold(
      body: Column(children: [
        GetBuilder<ProductDetailsController>(
          init: ProductDetailsController(),
          builder: (productDetailsController) {
            return Container(
              // padding: EdgeInsets.all(mq.width * 0.03),
              child: Expanded(
                child: GridView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (5 *
                            MediaQuery.of(context).size.height *
                            0.1), // Calculate aspect ratio

                    // mainAxisExtent:  130,
                    //mainAxisSpacing: 5,
                    // crossAxisSpacing: 15,
                  ),
                  itemCount: productDetailsController
                      .details.length, // Use actual item count
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(mq.width * 0.03),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddToCart(
                                          productDetails:
                                          productDetailsController
                                              .details[index])));
                            },
                            child: Container(
                              //padding: EdgeInsets.all(mq.width * 0.03),
                              height: mq.height * 0.2,
                              width: mq.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    productDetailsController
                                        .details[index].image
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              productDetailsController
                                  .details[index].productName
                                  .toString(),
                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
      ]),
    );
  }
}