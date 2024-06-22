import 'dart:convert';

import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../main.dart';
class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  @override
  TextEditingController _controller=TextEditingController();
  GlobalKey<FormState> key=GlobalKey<FormState>();
  var uuid=Uuid();
  String _sessionToken='123456';
  List<dynamic> _placesList=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken==null)
    {
      setState(() {
        _sessionToken=uuid.v4();
      });
    }
    else{
      getSuggestion(_controller.text);
    }
  }

  void getSuggestion(String input) async{
    String KPLACES_API_KEY="AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
    String baseURL='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request='$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response=await http.get(Uri.parse(request));
    var data=response.body.toString();

    if(response.statusCode==200)
    {
      setState(() {
        _placesList=jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception("Failed to load data");
    }

  }

  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          backgroundColor: Color.fromARGB(255, 15, 141, 6),
          title: Text("Set Location"),centerTitle: true,),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),

                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Search places with name",
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              _controller.clear();
                            },
                            child: Icon(Icons.cancel)),
                      ],

                    ),
                  ),

              ),
                   Expanded(
                     child: ListView.builder(
                            itemCount: _placesList.length,
                            itemBuilder:(context,index){
                              return ListTile(
                                onTap: () async{
                                  List<Location> locations = await locationFromAddress(_placesList[index]['description']);
                                  print(locations.last.latitude);
                                  print(locations.last.longitude);
                                  _controller.text=_placesList[index]['description'];
                                },
                                title: Text(_placesList[index]['description']),
                              );
                            }),
                   ),
                  InkWell(
                    onTap: () async{
                      if(_controller.text.isNotEmpty){
                        if(ServicesOrApis.user==null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BuyerProfilePage()));
                          Navigator.pop(context);
                        }
                        else{
                          List<Location> locations = await locationFromAddress(_controller.text);
                          double latitude = locations.last.latitude;
                          double longitude = locations.last.longitude;
                          String lat="$latitude";
                          String long="$longitude";
                          ServicesOrApis.addLocation(lat,long,_controller.text).then((value){
                            Get.snackbar(
                              'Success',
                              'Location Added successfully',
                              colorText: Colors.black,
                              backgroundColor: Colors.white24,
                              snackPosition: SnackPosition.TOP,
                              onTap: (SnackBar) {},
                            );
                          }).onError((error, stackTrace) {
                            Get.snackbar(
                              'Error',
                              'Check Internet',
                              colorText: Colors.black,
                              backgroundColor: Colors.white24,
                              snackPosition: SnackPosition.TOP,
                              onTap: (SnackBar) {},
                            );
                          });
                        }
                        Navigator.pop;
                      }
                      else{
                        Get.snackbar(
                          '',
                          'Select Any Address',
                          colorText: Colors.black,
                          backgroundColor: Colors.white24,
                          snackPosition: SnackPosition.TOP,
                          onTap: (SnackBar) {},
                        );
                      }

                    },
                    child: Container(
                      height: mq.height*0.07,
                      width: mq.width*0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 15, 141, 6),
                      ),
                      child: Center(child: Text("Confirm Your Location",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
