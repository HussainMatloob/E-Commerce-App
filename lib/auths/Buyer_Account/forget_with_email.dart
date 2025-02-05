import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ForgetWithEmailScreen extends StatefulWidget {
  const ForgetWithEmailScreen({super.key});

  @override
  State<ForgetWithEmailScreen> createState() => _ForgetWithEmailScreenState();
}

class _ForgetWithEmailScreenState extends State<ForgetWithEmailScreen> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  @override

  String? EmaileValidate(value)
  {
    if(value==null||value.toString().isEmpty)
    {
      return "Please enter an email";
    }
    bool emailreg=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if(emailreg==false)
    {
      return"Please enter valid email";
    }
  }

  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Form(
          key: logKey,
          child: ListView(
            children: [
              SizedBox(
                height: mq.height*0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    height: mq.height*0.18,
                    width: mq.width*0.38,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/Cart.jpg'),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(
                    width: mq.width*0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Easy",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.black),
                      ),
                      Text(
                        "Shopping",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Color.fromARGB(255, 15, 141, 6)),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: mq.height*0.1,
              ),
              const Center(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: Colors.black),
                  )),
               SizedBox(
                height: mq.height*0.06,
              ),

              Align(
                child: SizedBox(
                  width: mq.width*0.9,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,color:Color(0xffF323F4B),),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Color(0xffFBF9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: EmaileValidate,
                  ),
                ),
              ),
              SizedBox(
                height: mq.height*0.03,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {

                      },
                      child: const Text(
                        "Resend Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: 'Rubik Regular',
                            color: Colors.black),
                      )),
                ],
              ),
              SizedBox(
                height: mq.height*0.06,
              ),
              GetBuilder<Util>(
                init: Util(),
                builder: (utilController){
                  return Align(
                    child: GestureDetector(
                      onTap:(){
                        if(logKey.currentState!.validate())
                        {

                          utilController.forGotLoading(true);

                          auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                            utilController.forGotLoading(false);

                            Get.snackbar(
                              'Success',
                              'We have send you email to recover password please check email',
                              colorText: Colors.black,
                              backgroundColor: Colors.green,
                              snackPosition: SnackPosition.TOP,
                              onTap: (SnackBar) {},
                            );



                          }).onError((error, stackTrace){
                            utilController.forGotLoading(true);
                            Get.snackbar(
                              'Error',
                              error.toString().toString(),
                              colorText: Colors.black,
                              backgroundColor: Colors.green,
                              snackPosition: SnackPosition.TOP,
                              onTap: (SnackBar) {},
                            );
                          });
                        }
                      },
                      child: Container(
                        height: mq.height*0.08,
                        width: mq.width*0.8,
                        decoration:BoxDecoration(
                            color: Color.fromARGB(255, 15, 141, 6),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child:utilController.forgotPasswordLoading? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(
                            'Send',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Rubik Regular'),
                          ),
                        ),
                      ),
                    ),
                  );
                },

              ),
               
            ],
          ),
        ),
      ),
    );
  }
}
