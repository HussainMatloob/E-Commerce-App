import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/models/user_buy_product_details_model.dart';
import 'package:e_commerce_app/models/user_location-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class ServicesOrApis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  //static User get user => auth.currentUser!;
  static User? get user => auth.currentUser;
  static Future<bool> userExists() async {
    return (await fireStore.collection('CartUser').doc(user!.uid).get()).exists;

  }


  static Future<void> createUserWithEmailOrContact() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? Name = sp.getString('name');
    String? Contact = sp.getString('contact');
    String? password = sp.getString('password');
    String? userDeviceToken=sp.getString("deviceToken");
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final userProfile = UserProfile(
      id: user!.uid,
      password: password,
      userName: Name,
      contact: Contact,
      image: '',
      userDeviceToken:userDeviceToken,
      createdAt: time,
    );

    return await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .set(userProfile.toJson());
  }

  static Future<void> createUserWithGoogleAccount() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userDeviceToken=sp.getString("deviceToken");
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final userProfile = UserProfile(
      id: user!.uid,
      password: "",
      userName: user!.displayName.toString(),
      contact: user!.phoneNumber.toString(),
      image: '',
      userDeviceToken:userDeviceToken,
      createdAt: time,
    );

    return await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .set(userProfile.toJson());
  }

  static Future<bool> addProductToCart(ProductDetails productDetails) async {
    var data = await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('id', isEqualTo: productDetails.id.toString())
        .where('status', isEqualTo: "UnPayed")
        .get();

    if (data.docs.isEmpty) {
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      final cartModel = CartModel(
        productId: time,
        id: productDetails.id.toString(),
        productName: productDetails.productName.toString(),
        initialPrice: productDetails.price!,
        totalPrice: productDetails.price!,
        image: productDetails.image![0].toString(),
        quantity: 1.toString(),
        status: "UnPayed",
      );
      
      fireStore
          .collection('CartUser')
          .doc(user!.uid)
          .collection('BuyerItemsDetail')
          .doc(time)
          .set(cartModel.toJson());

      return true;
    } else {
      return false;
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> currentUser(){
    return fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartItems() {
    return fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('status', isEqualTo: "UnPayed")
        .snapshots();
  }

  static Future<void> DeleteItem(CartModel cartModel) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .delete();
  }

  static Future<void> addItemQuantity(CartModel cartModel,int price,int quantity) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .update({
      'totalPrice':price,
      'quantity':quantity.toString(),
    });
  }

  static Future<void> lessItemQuantity(CartModel cartModel,int price,int quantity) async {
    fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .doc(cartModel.productId)
        .update({
      'totalPrice':price,
      'quantity':quantity.toString(),
    });
  }
  static Future<void> addLocation(String latitude,String longitude,String address) async {

    final locationModel=UserLocationModel(
      id: user!.uid,
      latitude: latitude,
      longitude: longitude,
      address: address
    );

    fireStore
        .collection("CustomerLocation")
        .doc(user!.uid)
        .set(locationModel.toJson());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getYourLocation() {

    return fireStore
        .collection("CustomerLocation")
        .doc(user!.uid)
        .snapshots();
  }

  static Future<String> getAddress() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("CustomerLocation")
        .doc(user!.uid)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Assuming 'address' is the field name in your Firestore document
      String address = data['address'] ?? ''; // Get the address value
      return address;
    } else {
      // Document does not exist
      return '';
    }
  }

  static Future<void> forgotContactPassword(String newPassword) async{
    await fireStore
        .collection("CartUser")
        .doc(user!.uid)
        .update({
      "password":newPassword.toString(),
    });
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('customer_profile/${user!.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((po) {});

    var image = await ref.getDownloadURL();

    await fireStore.collection('CartUser').doc(user!.uid).update({
      'image': image,
    });
  }


  static Future<void> addTotalAndCount(ProductDetails productDetails) async{

      var docRef = fireStore.collection('CountAndTotal').doc(user!.uid);
      try {
        var doc = await docRef.get();
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            int currentTotal = int.parse(data['Total']);
            int count=int.parse(data['Counter']);

            int newTotal =  currentTotal+(int.parse(productDetails.price.toString()));
            int newCount=count+1;

            await docRef.update({'Total': newTotal.toString(),"Counter":newCount.toString()});
          }
        } else {
          await fireStore.collection('CountAndTotal').doc(user!.uid).set({
            "Total": productDetails.price.toString(),
            "Counter": 1.toString()
          });
        }
      } catch (error) {
        print("Error updating Total and Count: $error");
      }
  }


  static Future<void> lessTotalOfProduct(String initialPrice) async{

    var docRef = fireStore.collection('CountAndTotal').doc(user!.uid);
    try {
      var doc = await docRef.get();
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;


          int currentTotal = int.parse(data!['Total']);
          int newTotal =  -(int.parse(initialPrice))+currentTotal;
          await docRef.update({'Total': newTotal.toString(),});

    } catch (error) {
      print("Error updating Total and Count: $error");
    }
  }

  static Future<void> addTotalOfProduct(String initialPrice) async{

    var docRef = fireStore.collection('CountAndTotal').doc(user!.uid);
    try {
      var doc = await docRef.get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;


        int currentTotal = int.parse(data!['Total']);
        int newTotal =  (int.parse(initialPrice))+currentTotal;
        await docRef.update({'Total': newTotal.toString(),});

    } catch (error) {
      print("Error updating Total and Count: $error");
    }
  }

  static Future<void> lessTotalAndCount(CartModel cartModel) async{

    var docRef = fireStore.collection('CountAndTotal').doc(user!.uid);
    try {
      var doc = await docRef.get();
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          int currentTotal = int.parse(data['Total']);
          int count=int.parse(data['Counter']);

          int newTotal =  -(int.parse(cartModel.totalPrice.toString()))+currentTotal;
          int newCount=count-1;

          await docRef.update({'Total': newTotal.toString(),"Counter":newCount.toString()});
        }
       else {
        print("This Data already Removed");
      }


    } catch (error) {
      print("Error updating Total and Count: $error");
    }
  }

  static Future<bool> addBuyProductDetails(String paymentMethod,String name,String contact,String city,String address) async {


    var buyerItemsData = await fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('status', isEqualTo: "UnPayed")
        .get();

    if (buyerItemsData.docs.isNotEmpty) {
      var newData=buyerItemsData;
      var docRef = fireStore.collection('CountAndTotal').doc(user!.uid);
      var doc = await docRef.get();
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      String currentTotal =  data!['Total'];
      String count=data!['Counter'];

      final time = DateTime.now().millisecondsSinceEpoch.toString();
      final userBuyProductDetails = UserBuyProductDetails(
       name: name.toString(),
        contact: contact.toString(),
        city: city.toString(),
        address: address.toString(),
        totalAmount: currentTotal,
        totalProducts: count,
        order: "confirm",
        paymentmethod: paymentMethod,
      );

      fireStore
          .collection('UserBuyProductDetails')
          .doc(user!.uid)
          .collection('EachOrderDetail')
          .doc(time)
          .set( userBuyProductDetails.toJson()).then((value) async{
        await docRef.update({'Total': 0.toString(),"Counter":0.toString()}
        );

        for (var document in newData.docs) {
          await fireStore
              .collection('CartUser')
              .doc(user!.uid)
              .collection('BuyerItemsDetail')
              .doc(document.id)
              .update({'status': 'Payed'});
        }

      });
      return true;
    } else {
      return false;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCartOrderItems() {
    return fireStore
        .collection('CartUser')
        .doc(user!.uid)
        .collection('BuyerItemsDetail')
        .where('status', isEqualTo: "Payed")
        .snapshots();
  }

  static Future<void> addNewProductDetails(String category,String sale,File image,String productName,String productPrice,String productQuantity,String pDetails,String productSalePrice) async {

    try{

      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
        ..textColor = Colors.white // Color of the loading status text
        ..indicatorColor = Colors.white // Color of the loading indicator
        ..progressColor = Colors.white // Progress color of the loading indicator (if applicable)
        ..backgroundColor = Colors.green // Background color of the loading indicator
        ..maskColor = Colors.red; // Mask color of the loading (if applicable)
      EasyLoading.show(status: 'Please Wait...');

      final time = DateTime.now().millisecondsSinceEpoch.toString();

      final ext = image.path.split('.').last;
      final ref = storage.ref().child(
          'EasyShoppingImages/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}.$ext');
      await ref
          .putFile(image, SettableMetadata(contentType: 'image/$ext'))
          .then((po) {});
      String imageUrl = await ref.getDownloadURL();


      ProductDetails productDetails=ProductDetails(
        id: time.toString(),
        productName: productName.toString(),
        type: category.toString(),
        image: [imageUrl],
        price: int.parse(productPrice),
        quantity:int.parse(productQuantity),
        details: pDetails.toString(),
        salePrice: int.parse(productSalePrice),
        sale: sale.toString(),
        likes: "",
        rating: "",
        createdAt: time.toString(),
        updatedAt: time.toString(),
      );

    await fireStore.collection('EasyShoppingProducts').doc(time).set(productDetails.toJson());

      EasyLoading.dismiss();
      Get.snackbar(
        "Success",
        'Your Item added successfully',
        colorText: Colors.black,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        onTap: (SnackBar) {},
      );
    }
    catch(e){
      EasyLoading.dismiss();
      Get.snackbar('Error',e.toString(),
        colorText: Colors.black,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        icon: Icon(Icons.error,color: Colors.red,),
        onTap: (SnackBar){

        },
      );
      print("The Error is $e");
    }

    }
}
