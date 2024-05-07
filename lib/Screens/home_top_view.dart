import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/Screens/set_location_Screen.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_login_page.dart';
import 'package:e_commerce_app/controller/product_detail_controller.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:e_commerce_app/models/user_location-model.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';

class HomeTopView extends StatefulWidget {
  const HomeTopView({super.key});

  @override
  State<HomeTopView> createState() => _HomeTopViewState();
}

class _HomeTopViewState extends State<HomeTopView> {
  @override

  Completer<GoogleMapController> _controller=Completer();

  final CameraPosition _kgooglePlex=const CameraPosition(
      target: LatLng(37.09024,-95.712891),
      zoom: 14.4746);

  List<Marker> _marker=[];
  List<Marker> _list= const[
    Marker(markerId: MarkerId('1'),
      position:LatLng(37.09024,-95.712891),
      infoWindow:InfoWindow(
        title: 'My current Location',
      ),
    ),

  ];

@override

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    if(ServicesOrApis.user!=null){
      return GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        builder: (productDetailsController){
          return StreamBuilder(
              stream:ServicesOrApis.getYourLocation(),
              builder: (context,snapshot) {
                if(snapshot.hasData)
                {
                  final data = snapshot.data?.data();
                  if ( data!=null&&data.isNotEmpty) {

                    var locationData = UserLocationModel.fromJson(data);
                    double latitude=double.parse(locationData.latitude.toString());
                    double longitude=double.parse(locationData.longitude.toString());
                    print("lat is $latitude , long is $longitude");
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: mq.height * 0.32,
                            aspectRatio:MediaQuery.of(context).size.width /
                                (6 * MediaQuery.of(context).size.height * 0.1), // You can adjust the aspect ratio as needed
                            viewportFraction: 1.0, // Set viewport fraction to 1.0 for full page images
                            autoPlay: true,
                            enlargeCenterPage: false,
                          ),
                          items: productDetailsController.details.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    margin: EdgeInsets.only(bottom: mq.height * 0.02),
                                    height: mq.height * 0.5,
                                    width: mq.width * 0.9999,
                                    decoration:  BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                url.image!)))
                                );

                              },
                            );
                          }).toList(),
                        ),
                        InkWell(
                          onTap: (){
                            _marker.addAll(_list);
                            Get.bottomSheet(
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  GoogleMap(
                                    initialCameraPosition:CameraPosition(
                                        target: LatLng(latitude,longitude),
                                        zoom: 14.4746),
                                    mapType: MapType.normal,
                                    myLocationEnabled: true,
                                    compassEnabled: true,
                                    markers: Set<Marker>.of([ Marker(markerId: MarkerId('1'),
                                      position:LatLng(latitude,longitude),
                                      infoWindow:InfoWindow(
                                        title: 'My current Location',
                                      ),
                                    ),]),
                                    onMapCreated: (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    gestureRecognizers: Set()
                                      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                      ..add(Factory<VerticalDragGestureRecognizer>(
                                              () => VerticalDragGestureRecognizer())),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetLocation()));
                                      //Navigator.pop;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: mq.width*0.01),
                                      height: mq.height * 0.06,
                                      width: mq.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white70,
                                      ),
                                      child: Center(child: Text("Confirm",style: TextStyle(fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          },
                          child: Container(
                            height: mq.height*0.06,
                            width: mq.width*0.8,
                            padding:
                            EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                            decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(children: [
                              Icon(Icons.location_on_outlined,color: Colors.green,),
                              Text("Set your Delivery location"),
                            ],),
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: mq.height * 0.32,
                            aspectRatio:MediaQuery.of(context).size.width /
                                (6 * MediaQuery.of(context).size.height * 0.1), // You can adjust the aspect ratio as needed
                            viewportFraction: 1.0, // Set viewport fraction to 1.0 for full page images
                            autoPlay: true,
                            enlargeCenterPage: false,
                          ),
                          items: productDetailsController.details.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    margin: EdgeInsets.only(bottom: mq.height * 0.02),
                                    height: mq.height * 0.5,
                                    width: mq.width * 0.9999,
                                    decoration:  BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                url.image!)))
                                );

                              },
                            );
                          }).toList(),
                        ),
                        InkWell(
                          onTap: (){
                            _marker.addAll(_list);
                            Get.bottomSheet(
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  GoogleMap(
                                    initialCameraPosition: _kgooglePlex,
                                    mapType: MapType.normal,
                                    myLocationEnabled: true,
                                    compassEnabled: true,
                                    markers: Set<Marker>.of(_marker),
                                    onMapCreated: (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    gestureRecognizers: Set()
                                      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                      ..add(Factory<VerticalDragGestureRecognizer>(
                                              () => VerticalDragGestureRecognizer())),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetLocation()));
                                      //Navigator.pop;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: mq.width*0.01),
                                      height: mq.height * 0.06,
                                      width: mq.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white70,
                                      ),
                                      child: Center(child: Text("Confirm",style: TextStyle(fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          },
                          child: Container(
                            height: mq.height*0.06,
                            width: mq.width*0.8,
                            padding:
                            EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                            decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(children: [
                              Icon(Icons.location_on_outlined,color: Colors.green,),
                              Text("Set your Delivery location"),
                            ],),
                          ),
                        ),
                      ],
                    );
                  }
                }
                else{
                  print("Your Internet Problem");
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: mq.height * 0.32,
                          aspectRatio:MediaQuery.of(context).size.width /
                              (6 * MediaQuery.of(context).size.height * 0.1), // You can adjust the aspect ratio as needed
                          viewportFraction: 1.0, // Set viewport fraction to 1.0 for full page images
                          autoPlay: true,
                          enlargeCenterPage: false,
                        ),
                        items: productDetailsController.details.map((url) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: mq.height * 0.02),
                                  height: mq.height * 0.5,
                                  width: mq.width * 0.9999,
                                  decoration:  BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              url.image!)))
                              );

                            },
                          );
                        }).toList(),
                      ),
                      InkWell(
                        onTap: (){
                          _marker.addAll(_list);
                          Get.bottomSheet(
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                GoogleMap(
                                  initialCameraPosition: _kgooglePlex,
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  compassEnabled: true,
                                  markers: Set<Marker>.of(_marker),
                                  onMapCreated: (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  gestureRecognizers: Set()
                                    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                    ..add(Factory<VerticalDragGestureRecognizer>(
                                            () => VerticalDragGestureRecognizer())),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetLocation()));
                                    //Navigator.pop;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: mq.width*0.01),
                                    height: mq.height * 0.06,
                                    width: mq.width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white70,
                                    ),
                                    child: Center(child: Text("Confirm",style: TextStyle(fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ],
                            ),
                          );

                        },
                        child: Container(
                          height: mq.height*0.06,
                          width: mq.width*0.8,
                          padding:
                          EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                          decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(children: [
                            Icon(Icons.location_on_outlined,color: Colors.green,),
                            Text("Set your Delivery location"),
                          ],),
                        ),
                      ),
                    ],
                  );
                }
              }
          );
        },
      );
    }
    else{
      return GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(),
        builder: (productDetailsController){
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: mq.height * 0.32,
                  aspectRatio:MediaQuery.of(context).size.width /
                      (6 * MediaQuery.of(context).size.height * 0.1), // You can adjust the aspect ratio as needed
                  viewportFraction: 1.0, // Set viewport fraction to 1.0 for full page images
                  autoPlay: true,
                  enlargeCenterPage: true
                ),
                items: productDetailsController.details.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                     return Container(
                        margin: EdgeInsets.only(bottom: mq.height * 0.02),
                        height: mq.height * 0.5,
                        width: mq.width * 0.9999,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    url.image!)))
                      );

                    },
                  );
                }).toList(),
              ),
              InkWell(
                onTap: (){
                  if(ServicesOrApis.user==null){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyerLoginPage()));
                  }
                  else{
                    _marker.addAll(_list);
                    Get.bottomSheet(
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GoogleMap(
                            initialCameraPosition: _kgooglePlex,
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            markers: Set<Marker>.of(_marker),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            gestureRecognizers: Set()
                              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                              ..add(Factory<VerticalDragGestureRecognizer>(
                                      () => VerticalDragGestureRecognizer())),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetLocation()));
                              //Navigator.pop;
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: mq.width*0.01),
                              height: mq.height * 0.06,
                              width: mq.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white70,
                              ),
                              child: Center(child: Text("Confirm",style: TextStyle(fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Container(
                  height: mq.height*0.06,
                  width: mq.width*0.8,
                  padding:
                  EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05),
                  decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(children: [
                    Icon(Icons.location_on_outlined,color: Colors.green,),
                    Text("Set your Delivery location"),
                  ],),
                ),
              ),
            ],
          );
        },

      );
    }
  }
}
