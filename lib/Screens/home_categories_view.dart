
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:e_commerce_app/widgets/categories_buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_detail_controller.dart';
import '../main.dart';
import 'watches_screen.dart';

class HomeCategoriesView extends StatefulWidget {
  const HomeCategoriesView({super.key});

  @override
  State<HomeCategoriesView> createState() => _HomeCategoriesViewState();
}

class _HomeCategoriesViewState extends State<HomeCategoriesView> {
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

    return Container(
        margin: EdgeInsets.only(
            top: mq.height * 0.02,
            left: mq.width * 0.017,
            right: mq.width * 0.017),
        height: mq.height * 0.47,
        width: mq.width * 0.95,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mq.width * 0.03,
                  right: mq.width * 0.03,
                  top: mq.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("Inspired by your interests")
                    ],
                  ),
                  GetBuilder<Util>(
                    init: Util(),
                    builder: (util){
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesButtonsTabbar()));
                        },
                        child: Container(
                          height: mq.height * 0.04,
                          width: mq.width * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: Colors.red)),
                          child: const Center(
                              child: Text(
                                "See More >",
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      );
                    },

                  ),
                ],
              ),
            ),
            GetBuilder<ProductDetailsController>(
              init: ProductDetailsController(),
              builder: (productDetailsController) {
                return Container(
                  child: Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //mainAxisExtent: 80,
                      ),
                      itemCount: productDetailsController
                          .details.length, // Use actual item count
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(mq.width * 0.03),
                              height: mq.height * 0.13,
                              width: mq.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
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
                            Center(
                              child: Text(
                                productDetailsController
                                    .details[index].productName
                                    .toString(),
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
