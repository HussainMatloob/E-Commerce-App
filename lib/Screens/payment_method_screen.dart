import 'package:e_commerce_app/Screens/set_location_Screen.dart';
import 'package:e_commerce_app/controller/payment_controller.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../main.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  GlobalKey<FormState> fieldsKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    ServicesOrApis.getAddress().then((value){
      addressController.text=value.toString();
    });
  }

  String? contactValidate(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your Phone number";
    }
    bool contactRegex = RegExp(r'^[0-9]+$').hasMatch(value);

    if (contactRegex == false) {
      return "Please enter valid number";
    }
    return null;
  }
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFD6D6D6),
      appBar: AppBar(),
      body: GetBuilder<SelectPaymentMethod>(
        init: SelectPaymentMethod(),
        builder: (selectPaymentMethod){
         return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: mq.width * 0.02, top: mq.height * 0.02),
                        height: mq.height * 0.07,
                        width: mq.width * 0.999,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Text(
                          "Payment Methods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white70),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectPaymentMethod.selectJazCash?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                           selectPaymentMethod.payJazCash(true);
                           selectPaymentMethod.payMethod("JazzCash");
                          },
                          leading: Container(
                            height:
                            mq.height * 0.1, // Adjust these dimensions as needed
                            width: mq.width * 0.1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/Jazz cash logo vector.png"),
                                fit: BoxFit
                                    .scaleDown, // Use BoxFit.scaleDown to make the image smaller
                              ),
                            ),
                          ),
                          title: Text(
                            "JazzCash",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: selectPaymentMethod.selectJazCash?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectPaymentMethod.selectHBL?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            selectPaymentMethod.payHBl(true);
                            selectPaymentMethod.payMethod("HBL Bank Account");
                          },
                          leading: Container(
                            height: mq.height * 0.1,
                            width: mq.width * 0.1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/HBL Logo.png"),
                                fit: BoxFit
                                    .scaleDown, // Adjust this based on your requirement
                              ),
                            ),
                          ),
                          title: Text(
                            "HBL Bank Account",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: selectPaymentMethod.selectHBL?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectPaymentMethod.selectInstalment?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            selectPaymentMethod.payInStallment(true);
                            selectPaymentMethod.payMethod("Installment");
                          },
                          leading: Icon(
                            Icons.calendar_month_rounded,
                            size: mq.width * 0.097,
                          ),
                          title: Text(
                            "Installment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: selectPaymentMethod.selectInstalment?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectPaymentMethod.selectEasyPais?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            selectPaymentMethod.payEasyPais(true);
                            selectPaymentMethod.payMethod("EasyPaisa");
                          },
                          leading: Container(
                            height: mq.height * 0.1,
                            width: mq.width * 0.1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/EasyPasa.png"),
                                fit: BoxFit
                                    .scaleDown, // Adjust this based on your requirement
                              ),
                            ),
                          ),
                          title: Text(
                            "EasyPaisa",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: selectPaymentMethod.selectEasyPais?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectPaymentMethod.selectCashOnDelivery?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            selectPaymentMethod.payCashOnDelivery(true);
                            selectPaymentMethod.payMethod("Cash On Delivery");
                          },
                          leading: Icon(
                            Icons.local_atm_outlined,
                            size: mq.width * 0.097,
                          ),
                          title: Text(
                            "Cash On Delivery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: selectPaymentMethod.selectCashOnDelivery?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {

                  if(selectPaymentMethod.payBy==null||selectPaymentMethod.payBy.isEmpty)
                    {
                      Get.snackbar(
                        '',
                        'Please Must select Payment Method',
                        colorText: Colors.black,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        onTap: (SnackBar) {},
                      );
                    }
                  else if(addressController.text==null||addressController.text.isEmpty){
                    Get.snackbar(
                      '',
                      'Please set your location',
                      colorText: Colors.black,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.TOP,
                      onTap: (SnackBar) {},
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetLocation()));
                  }
                  else{
                    Get.bottomSheet(
                      Form(
                        key: fieldsKey,
                        child: Container(
                          // height: mq.height * 0.2, // Adjust the height as needed
                          // width: mq.width*0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: mq.height * 0.03,
                                            left: mq.width * 0.06,
                                            right: mq.width * 0.06),
                                        child: TextFormField(
                                          controller: nameController,
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: mq.height*0.04,left: mq.width*0.03),
                                            //hintText: "Name",
                                            labelText: "Name",
                                            labelStyle: TextStyle(color: Colors.green),
                                           // hintStyle: TextStyle(color: Colors.green),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return "Please enter your Name";
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: mq.height * 0.03,
                                            left: mq.width * 0.06,
                                            right: mq.width * 0.06),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly, // Allow only digits
                                          ],
                                          controller: contactController,
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: mq.height*0.04,left: mq.width*0.03),
                                           // hintText: "Contact",
                                            label: Text("Contact"),
                                            labelStyle: TextStyle(color: Colors.green),
                                           // hintStyle: TextStyle(color: Colors.green),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                          ),
                                          validator: contactValidate,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: mq.height * 0.03,
                                            left: mq.width * 0.06,
                                            right: mq.width * 0.06),
                                        child: TextFormField(
                                          controller: cityController,
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: mq.height*0.04,left: mq.width*0.03),
                                            //hintText: "City",
                                            label: Text("City"),
                                            labelStyle: TextStyle(color: Colors.green),
                                           // hintStyle: TextStyle(color: Colors.green),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return "Please enter your City Name";
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: mq.height * 0.03,
                                            left: mq.width * 0.06,
                                            right: mq.width * 0.06),
                                        child: TextFormField(
                                         // enabled: false,
                                          controller: addressController,
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: mq.height*0.04,left: mq.width*0.03),
                                           // hintText: "Address",
                                            label: Text("Address"),
                                            labelStyle: TextStyle(color: Colors.green),
                                           // hintStyle: TextStyle(color: Colors.green),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide:
                                              BorderSide(color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return "Please enter your Address";
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: mq.width*0.07,right:mq.width*0.06,bottom: mq.height*0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    StreamBuilder(
                                      stream:  ServicesOrApis.fireStore.collection('CountAndTotal').doc(ServicesOrApis.user!.uid).snapshots(),
                                      builder: (context,snapshot){
                                        if(snapshot.hasData){
                                          var data=snapshot.data?.data();
                                          if(data!=null&&data.isNotEmpty){
                                            return  Container(
                                              child: Center(child: Text("Total:"+data['Total'].toString(),style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),),
                                            );
                                          }
                                          else{
                                            return  Container(
                                              child: Center(child: Text("Total:0",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),),
                                            );
                                          }
                                        }
                                        else{
                                          return  Container(
                                            child: Center(child: Text("Total:0",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),),
                                          );
                                        }
                                    },
                                    ),
                                    InkWell(
                                      onTap: () {

                                        if(fieldsKey.currentState!.validate()){
                                          try{
                                            EasyLoading.instance
                                              ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
                                              ..textColor = Colors.white // Color of the loading status text
                                              ..indicatorColor = Colors.white // Color of the loading indicator
                                              ..progressColor = Colors.white // Progress color of the loading indicator (if applicable)
                                              ..backgroundColor = Colors.green // Background color of the loading indicator
                                              ..maskColor = Colors.red; // Mask color of the loading (if applicable)
                                            EasyLoading.show(status: 'Please Wait...');
                                            ServicesOrApis.addBuyProductDetails(selectPaymentMethod.payBy,nameController.text,contactController.text,cityController.text,addressController.text).then((value) =>{
                                              if(value==true){
                                                EasyLoading.dismiss(),
                                                Get.snackbar(
                                                  'Success',
                                                  'Your order Confirmed',
                                                  colorText: Colors.black,
                                                  backgroundColor: Colors.green,
                                                  snackPosition: SnackPosition.TOP,
                                                  onTap: (SnackBar) {},
                                                ),
                                                   Navigator.pop(context),
                                              }
                                              else{
                                              EasyLoading.dismiss(),
                                                Get.snackbar(
                                                  '',
                                                  'Please must Add anyone item to your cart',
                                                  colorText: Colors.black,
                                                  backgroundColor: Colors.green,
                                                  snackPosition: SnackPosition.TOP,
                                                  onTap: (SnackBar) {},
                                                ),
                                              }
                                            });
                                          }
                                          catch(error){
                                            EasyLoading.dismiss();
                                            print("Error $error");
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: mq.width * 0.01),
                                        height: mq.height * 0.06,
                                        width: mq.width * 0.34,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.green,
                                        ),
                                        child: Center(
                                            child: Text(
                                              "Place Order",
                                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  height: mq.height * 0.07,
                  width: mq.width * 0.999,
                  decoration: BoxDecoration(color: Colors.green),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
