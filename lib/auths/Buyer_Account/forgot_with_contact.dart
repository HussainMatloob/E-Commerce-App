import 'package:e_commerce_app/auths/Buyer_Account/name_screen.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ForgotContactPassword extends StatefulWidget {
  const ForgotContactPassword({super.key});

  @override
  State<ForgotContactPassword> createState() => _ForgotContactPasswordState();
}

class _ForgotContactPasswordState extends State<ForgotContactPassword> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  @override
  String? PasswordValidate(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter password";
    }
    bool passRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$').hasMatch(value);
    if (passRegex == false) {
      return "Minimum 6 character with a number and letter";
    }
    return null;
  }
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Form(
        key: logKey,
        child: Column(
          children: [
            Text("Please enter new password"),
            SizedBox(height: mq.height*0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width*0.05),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color(0xffF323F4B)),
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffEE7EB)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffEE7EB)),
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xffFBF9FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: PasswordValidate,
              ),
            ),

            SizedBox(
              height: mq.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (logKey.currentState!.validate()) {

                    ServicesOrApis.forgotContactPassword(passwordController.text).then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NameScreen()));

                      Get.snackbar(
                        'Success',
                        'Your password updated successfully',
                        colorText: Colors.black,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        onTap: (SnackBar) {},
                      );
                    }).onError((error, stackTrace){
                      Get.snackbar(
                        'Error',
                        error.toString(),
                        colorText: Colors.black,
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.TOP,
                        onTap: (SnackBar) {},
                      );
                    });

                }
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
    );
  }
}
