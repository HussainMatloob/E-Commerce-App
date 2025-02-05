import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../main.dart';
import 'name_screen.dart';

class OtpScreen extends StatefulWidget {
  String varificationId;
  OtpScreen({super.key, required this.varificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  String pinCode = '';

  @override


  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mq.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Enter the code",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: mq.height * 0.02,
                    ),
                    PinCodeTextField(
                        appContext: context,
                        length: 6,
                        cursorColor: Colors.teal,
                        keyboardType: TextInputType.number,
                        //obscureText: true,
                        //obscuringCharacter: '*',
                        enabled: true,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor: Colors.grey,
                          activeFillColor: Colors.teal,
                          inactiveFillColor: Colors.grey,
                          selectedFillColor: Colors.red,
                          inactiveColor: Colors.red,
                          selectedColor: Colors.blue,
                        ),
                        onCompleted: (value) {
                          pinCode = value;
                        },
                        onChanged: (value) {}),
                  ],
                ),
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              InkWell(
                onTap: () async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                            verificationId: widget.varificationId,
                            smsCode: pinCode);

                    FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) {
                      Get.snackbar(
                        'Success',
                        'You register successfully',
                        colorText: Colors.black,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        onTap: (SnackBar) {},
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NameScreen()));
                    }).onError((error, stackTrace) {
                      Get.snackbar(
                        'Error',
                        error.toString(),
                        colorText: Colors.black,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        onTap: (SnackBar) {},
                      );
                    });
                  } catch (e) {}

                  // Get.to(NameScreen());
                },
                child: Container(
                  height: mq.height * 0.07,
                  width: mq.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
