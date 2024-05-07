import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/auths/Buyer_Account/email_signup.dart';
import 'package:e_commerce_app/auths/Buyer_Account/forget_with_email.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({super.key});

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();

  @override

  final _auth=FirebaseAuth.instance;

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

  String? PasswordValidate(value)
  {
    if(value==null||value.trim().isEmpty)
    {
      return"Please enter password";
    }
    return null;
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
                        "Shopping",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Rubik Medium',
                            color: Colors.black),
                      ),
                      Text(
                        "Cart",
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
              Align(
                child: SizedBox(
                  width: mq.width*0.9,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailCon,
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
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: EmaileValidate,
                  ),
                ),
              ),
               SizedBox(
                height: mq.height*0.04,
              ),

              GetBuilder<Util>(
                init:Util(),
                  builder:(controller){
                    return  Align(
                      child: SizedBox(
                        width: mq.width*0.9,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passCon,
                          obscureText:controller.obsecurePasswordLogin,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color:Color(0xffF323F4B)),
                            focusedBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffEE7EB)),
                            ),
                            enabledBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffEE7EB)),
                            ),
                            hintText: 'Password',
                            filled: true,
                            fillColor: Color(0xffFBF9FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: InkWell(
                                onTap: (){
                                  controller.ObsecureLogin(controller.obsecurePasswordLogin);
                                },
                                child:controller.obsecurePasswordLogin? Icon(Icons.visibility_off_outlined):Icon(Icons.remove_red_eye)
                            ),
                          ),
                          validator: PasswordValidate,
                        ),
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(ForgetWithEmailScreen());
                      },
                      child: const Text(
                        "Forgot Password",
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
                  builder:(controller){
                    return Align(
                      child: GestureDetector(
                        onTap:(){
                          if(logKey.currentState!.validate())
                          {
                            controller.loadingFunctionLogin(controller.loadingLogin);
                            _auth.signInWithEmailAndPassword(email:emailCon.text.toString(),
                                password: passCon.text.toString()).then((value) async{
                              controller.loadingFunctionLogin(controller.loadingLogin);

                              if (value != null) {
                                if ((await ServicesOrApis.userExists())) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => HomeBottomBar()));
                                } else {
                                  await ServicesOrApis.createUser().then((value) {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => HomeBottomBar()));
                                  });
                                }

                                Get.snackbar(
                                  'Success',
                                  'You login successfully',
                                  colorText: Colors.black,
                                  backgroundColor: Colors.green,
                                  snackPosition: SnackPosition.TOP,
                                  onTap: (SnackBar) {},
                                );
                              }

                            }).onError((error, stackTrace){
                              controller.loadingFunctionLogin(controller.loadingLogin);
                              Get.snackbar('Error',error.toString(),
                                colorText: Colors.black,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                icon: Icon(Icons.error,color: Colors.red,),
                                onTap: (SnackBar){

                                },
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
                          child:Center(
                            child:controller.loadingLogin?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):
                            const Text(
                              'LOG IN',
                              style:TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'Rubik Regular'),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                SizedBox(
                height: mq.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                   SizedBox(
                    width: mq.width*0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>CustomerSignupPage()));
                        //Get.to(CustomerSignupPage());
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromARGB(255, 15, 141, 6),
                            fontFamily: 'Rubik Regular'),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
