import 'package:e_commerce_app/controller/payment_controller.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/views/screens/set_location_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../main.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  PaymentMethodsController paymentMethodsController=Get.put(PaymentMethodsController());
  GlobalKey<FormState> fieldsKey=GlobalKey<FormState>();

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    paymentMethodsController.initializePaymentMethod();
    ServicesOrApis.getAddress().then((value){
      paymentMethodsController.addressController.text=value.toString();
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
      body: GetBuilder<PaymentMethodsController>(
        init: PaymentMethodsController(),
        builder: (paymentController){
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
                        child:const Text(
                          "Payment Methods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white70),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: paymentController.selectJazCash?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                           paymentController.payJazCash(true);
                           paymentController.payMethod("JazzCash");
                          },
                          leading: Container(
                            height:
                            mq.height * 0.1, // Adjust these dimensions as needed
                            width: mq.width * 0.1,
                            decoration:const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/Jazz cash logo vector.png"),
                                fit: BoxFit
                                    .scaleDown, // Use BoxFit.scaleDown to make the image smaller
                              ),
                            ),
                          ),
                          title:const Text(
                            "JazzCash",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: paymentController.selectJazCash?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),

                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: paymentController.selectEasyPais?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            paymentController.payEasyPais(true);
                            paymentController.payMethod("EasyPaisa");
                          },
                          leading: Container(
                            height: mq.height * 0.1,
                            width: mq.width * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/EasyPasa.png"),
                                fit: BoxFit
                                    .scaleDown, // Adjust this based on your requirement
                              ),
                            ),
                          ),
                          title:const Text(
                            "EasyPaisa",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: paymentController.selectEasyPais?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: paymentController.selectStripe?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            paymentController.payStripe(true);
                            paymentController.payMethod("Stripe");
                          },
                          leading: Container(
                            height: mq.height * 0.1,
                            width: mq.width * 0.1,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/Stripe.png"),
                                fit: BoxFit
                                    .scaleDown, // Adjust this based on your requirement
                              ),
                            ),
                          ),
                          title:const Text(
                            "Stripe",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: paymentController.selectStripe?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: paymentController.selectCardPayment?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            paymentController.payWithCard(true);
                            paymentController.payMethod("Card Payment");
                          },
                          leading: Icon(
                            Icons.calendar_month_rounded,
                            size: mq.width * 0.097,
                          ),
                          title:const Text(
                            "Card Payment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: paymentController.selectCardPayment?Icon(Icons.done_outline_outlined):null,
                        ),
                      ),

                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: paymentController.selectCashOnDelivery?Colors.green:Colors.transparent,
                        ),
                        child: ListTile(
                          onTap: () {
                            paymentController.payCashOnDelivery(true);
                            paymentController.payMethod("Cash On Delivery");
                          },
                          leading: Icon(
                            Icons.local_atm_outlined,
                            size: mq.width * 0.097,
                          ),
                          title:const Text(
                            "Cash On Delivery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: paymentController.selectCashOnDelivery?Icon(Icons.done_outline_outlined):null,
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
                  if(paymentController.payBy==""||paymentController.payBy.isEmpty)
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
                  else if(paymentMethodsController.addressController.text.isEmpty){
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
                    if(paymentController.payBy=="JazzCash"){
                       paymentMethodsController.payWithJazzCash(context);
                    }
                    else if(paymentController.payBy=="EasyPaisa"){
                      paymentMethodsController.payWithEasyPaisa(context);
                    }
                    else if(paymentController.payBy=="Stripe"){
                      paymentMethodsController.makePayment();
                    }
                    else if(paymentController.payBy=="Card Payment"){
                      paymentMethodsController.paymentWithCards(context);
                    }
                    else{
                      Get.bottomSheet(
                        Form(
                          key: fieldsKey,
                          child: Container(
                            // height: mq.height * 0.2, // Adjust the height as needed
                            // width: mq.width*0.9,
                            decoration:const BoxDecoration(
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
                                            controller: paymentMethodsController.nameController,
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
                                            controller:  paymentMethodsController.contactController,
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
                                            controller:  paymentMethodsController.cityController,
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
                                            controller:  paymentMethodsController.addressController,
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
                                            paymentController.paymentMethod(context);
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
                                          child:const Center(
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
                  }
                },
                child: Container(
                  height: mq.height * 0.07,
                  width: mq.width * 0.999,
                  decoration: BoxDecoration(color: Colors.green),
                  child: const Center(
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
