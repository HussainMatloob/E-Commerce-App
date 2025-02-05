import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/views/screens/add_to_cart_screen.dart';
import 'package:e_commerce_app/views/screens/sale_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';
import '../../controller/product_detail_controller.dart';
import '../../main.dart';
import '../../models/product_details.dart';
import '../../services/services.dart';
import '../custom_widgets/All_categories_buttons_tabbar.dart';
import '../custom_widgets/reuseable_categories_widget.dart';
import 'all_product_screen.dart';

class HomeCategoriesView extends StatefulWidget {
  const HomeCategoriesView({super.key});

  @override
  State<HomeCategoriesView> createState() => _HomeCategoriesViewState();
}

class _HomeCategoriesViewState extends State<HomeCategoriesView>
    with TickerProviderStateMixin {
  late final AnimationController _controllerAnimate =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat();
  List<ProductDetails> details=[];
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                top: mq.height * 0.02,
                left: mq.width * 0.017,
                right: mq.width * 0.017),
            height: mq.height * 0.33,
            width: mq.width * 0.95,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                CategoriesWidget(
                  headingTitle: "Categories",
                  headingSubtitle: "According to your choice",
                  buttonText: "See More >",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllCategoriesButtonsTabbar()));
                  },
                ),
                GetBuilder<ProductDetailsController>(
                  init: ProductDetailsController(),
                  builder: (productDetailsController) {
                    return Container(
                      child: Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 125,
                          ),
                          itemCount: productDetailsController
                              .categoriesItem.length, // Use actual item count
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(mq.width * 0.02),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails: productDetailsController.categoriesItem[index],)));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only( bottom:mq.width*0.02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: mq.height * 0.17,
                                          width: mq.width * 0.5,
                                          imageUrl: productDetailsController
                                              .categoriesItem[index].image![0]
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
                                  Center(
                                    child: Text(
                                      productDetailsController
                                          .categoriesItem[index].productName
                                          .toString(),overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
        Container(
            margin: EdgeInsets.only(
                top: mq.height * 0.02,
                left: mq.width * 0.017,
                right: mq.width * 0.017),
            height: mq.height * 0.35,
            width: mq.width * 0.95,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                CategoriesWidget(
                  headingTitle: "Flash Sale",
                  headingSubtitle: "According to your choice",
                  buttonText: "See More >",
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesProductScreen()));
                  },
                ),
                GetBuilder<ProductDetailsController>(
                  init: ProductDetailsController(),
                  builder: (productDetailsController) {
                    return Container(
                      child: Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 125,
                          ),
                          itemCount: productDetailsController
                              .salesItem.length, // Use actual item count
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(mq.width * 0.02),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails: productDetailsController.salesItem[index],)));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only( bottom:mq.width*0.02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: mq.height * 0.17,
                                          width: mq.width * 0.5,
                                          imageUrl: productDetailsController
                                              .salesItem[index].image![0]
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
                                 Center(
                                   child: Text(
                                     productDetailsController
                                         .salesItem[index].productName
                                         .toString(),overflow: TextOverflow.ellipsis,
                                     style: TextStyle(fontSize: 10),
                                     textAlign: TextAlign.center,
                                   ),),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                   Center(
                                     child: Text("Rs:"+
                                       productDetailsController
                                           .salesItem[index].salePrice
                                           .toString(),
                                       style: TextStyle(fontSize: 10),
                                       textAlign: TextAlign.center,
                                     ),),
                                   SizedBox(width: mq.width*0.01,),
                                   Center(
                                     child: Text(
                                         productDetailsController
                                             .salesItem[index].price
                                             .toString(),
                                       style: TextStyle(fontSize: 10,decoration: TextDecoration.lineThrough),
                                       textAlign: TextAlign.center,
                                     ),),
                                 ],),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),


        Container(
            margin: EdgeInsets.only(
                top: mq.height * 0.02,
                left: mq.width * 0.017,
                right: mq.width * 0.017
            ),
            decoration: BoxDecoration(
                color: Colors.white,),
            child: Column(
              children: [
                CategoriesWidget(
                  headingTitle: "All Products",
                  headingSubtitle: "According to your choice",
                  buttonText: "See More >",
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductsScreen()));
                  },
                ),
                Container(
                  margin: EdgeInsets.all(mq.width * 0.02),
                  child: PaginateFirestore(
                    itemBuilder: (context,documentSnapshot,index){
                      ProductDetails productDetails=ProductDetails.fromJson(documentSnapshot[index].data() as Map<String,dynamic>);
                      return  Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToCart(productDetails:productDetails,)));
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
                      );
                    },
                    query: ServicesOrApis.getAllProducts(), itemBuilderType: PaginateBuilderType.gridView,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Set the number of columns you want
                        crossAxisSpacing: 15,mainAxisExtent: 200
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    onEmpty:Center(
                        child: Text(
                          "There is no any product!",
                          style: TextStyle(fontSize:20),
                        )),
                  ),
                ),

              ],
            )),
      ],
    );
  }
}
