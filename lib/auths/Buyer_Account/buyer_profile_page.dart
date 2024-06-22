import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Screens/admin_screens/admin_panel_screen.dart';
import 'package:e_commerce_app/Screens/orders_screen.dart';
import 'package:e_commerce_app/widgets/home_bottom_bar.dart';

import 'package:e_commerce_app/Screens/set_location_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/home_screen.dart';
import '../../main.dart';
import '../../models/user_profile.dart';
import '../../services/services.dart';
import 'buyer_login_page.dart';

class BuyerProfilePage extends StatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  State<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends State<BuyerProfilePage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          builder: (_) {
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  top: mq.height * .03, bottom: mq.height * .05),
              children: [
                Text(
                  "pick profile picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: Size(mq.width * .3, mq.height * .15)),
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          Navigator.pop(context);
                          if (image != null) {
                            print(
                                'Image Path: ${image.path} -- MimeType: ${image.mimeType}');

                            await ServicesOrApis.updateProfilePicture(
                                File(image.path));
                            // APIs.updateProfilePicture(File(_image!));
                          }
                        },
                        child: Image.asset('images/GallryPhoto.png')),
                    // SizedBox(
                    //   width: mq.width * .15,
                    // ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: Size(mq.width * .3, mq.height * .15)),
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 80);
                          Navigator.pop(context);
                          if (image != null) {
                            print('Image Path: ${image.path}');
                            await ServicesOrApis.updateProfilePicture(
                                File(image.path));
                          }
                        },
                        child: Image.asset('images/CameraPhoto.png')),
                  ],
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 141, 6),
        leading: ServicesOrApis.user != null
            ? null
            : Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 40,
              ),
        title: ServicesOrApis.user == null
            ? Text(
                "Hello, Welcome to Shopping Cart!",
                style: TextStyle(fontSize: 12, color: Colors.white),
              )
            : Container(),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.settings_outlined),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SetLocation()));
                  },
                  child: ListTile(
                    title: Text(
                      "Set Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.location_on),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: ListTile(
                  onTap: () {
                    if(ServicesOrApis.user!=null){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersScreen()));
                    }
                    else{
                     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BuyerLoginPage()));
                    }
                  },
                  leading: Icon(
                    Icons.shopping_bag_outlined,
                  ),
                  title: Text(
                    "Orders",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: InkWell(
                  onTap: () async {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeBottomBar()));
                    ServicesOrApis.auth.signOut();
                    GoogleSignIn().signOut();
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text("LogOut",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: mq.width * 0.03,
          )
        ],
      ),
      body: Column(
        children: [
          ServicesOrApis.user == null
              ? Container(
                  height: mq.height * 0.2,
                  width: mq.width * 0.9999,
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 15, 141, 6)),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyerLoginPage()));
                    },
                    child: Container(
                      height: mq.height * 0.07,
                      width: mq.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Login / Sign up",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                )
              : StreamBuilder(
                  stream: ServicesOrApis.fireStore
                      .collection('CartUser')
                      .where('id', isEqualTo: ServicesOrApis.user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // final data = snapshot.data?.data();
                      final data = snapshot.data?.docs;
                      if (data != null) {
                        // final list = UserProfile.fromJson(data);
                        final list = data
                                .map((e) => UserProfile.fromJson(e.data()))
                                .toList() ??
                            [];

                        return Container(
                                  padding:
                                      EdgeInsets.only(bottom: mq.height * 0.12),
                                  height: mq.height * 0.2,
                                  width: mq.width * 0.999,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 15, 141, 6)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: mq.width * 0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _showBottomSheet(context);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            width: mq.width * .17,
                                            height: mq.height * .2,
                                            fit: BoxFit.cover,
                                            imageUrl: list[0].image ?? "",
                                            // placeholder: (context, url) => CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                    error) =>
                                                CircleAvatar(
                                                    child: Icon(
                                                        CupertinoIcons.person)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mq.width * 0.03,
                                      ),
                                      Text(
                                        list[0].userName.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPanel()));
            },
            child: Center(
              child: Container(
               height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(child: Text("Admin",style: TextStyle(fontWeight: FontWeight.bold),),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
