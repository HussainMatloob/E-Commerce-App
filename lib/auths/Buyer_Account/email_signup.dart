import 'package:e_commerce_app/auths/Buyer_Account/email_login.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/get_device_token_controller.dart';
import '../../main.dart';

class CustomerSignupPage extends StatefulWidget {
  const CustomerSignupPage({super.key});

  @override
  State<CustomerSignupPage> createState() => _CustomerSignupPageState();
}

class _CustomerSignupPageState extends State<CustomerSignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final TextEditingController contactController=TextEditingController();
  final TextEditingController nameController = TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;

  @override

  String? nameValidate(value)
  {
    if(value==null||value.trim().isEmpty)
    {
      return "Please enter name";
    }

    bool nameRegx=RegExp(r'^[a-zA-Z ]+$').hasMatch(value);
    if(nameRegx==false)
    {
      return "Please enter valid name";
    }
    return null;
  }
  String? contactValidate(value)
  {
    if(value==null||value.trim().isEmpty)
    {
      return "Please enter Contact number";
    }
    bool contactRegex=RegExp(r'^[0-9]+$').hasMatch(value);
    if(contactRegex==false)
    {
      return"Please enter number with digits";
    }
    return null;
  }
  String? EmailValidate(value)
  {
    if(value==null||value.trim().isEmpty)
    {
      return "Please enter an email";
    }
    bool emailReg=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if(emailReg==false)
    {
      return"Please enter valid email";
    }
    return null;
  }
  String? PasswordValidate(value)
  {
    if(value==null||value.trim().isEmpty)
    {
      return"Please enter password";
    }
    bool passRegex=RegExp( r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$').hasMatch(value);
    if(passRegex==false)
    {
      return "Password must contain at least one lowercase, \none uppercase, one digit, and one special character";
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
              Align(
                child: SizedBox(
                  width: mq.width*0.9,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:  nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person,color:Color(0xffF323F4B),),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder:const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Name',
                      filled: true,
                      fillColor: Color(0xffFBF9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: nameValidate,
                  ),
                ),
              ),
              SizedBox(
                height: mq.height*0.04,
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
                    validator:  EmailValidate,
                  ),
                ),
              ),
              SizedBox(
                height: mq.height*0.04,
              ),

              GetBuilder<Util>(
                init:Util(),
                  builder:(controller){
                    return Align(
                      child: SizedBox(
                        width: mq.width*0.9,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          obscureText:controller.obsecurePasswordSignup,
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
                                  controller.ObsecureSignup(controller.obsecurePasswordSignup);
                                },
                                child:controller.obsecurePasswordSignup? Icon(Icons.visibility_off_outlined):Icon(Icons.remove_red_eye)
                            ),

                          ),
                          validator: PasswordValidate,
                        ),
                      ),
                    );
                  }),

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
                            controller.loadingFunctionSignup(controller.loadingSignup);
                            _auth.createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passwordController.text.toString()).then((value)async{
                              controller.loadingFunctionSignup(controller.loadingSignup);
                              SharedPreferences sp = await SharedPreferences.getInstance();
                              sp.setString('name', nameController.text);
                              final DeviceTokenController deviceTokenController=Get.put(DeviceTokenController());
                              sp.setString('deviceToken', deviceTokenController.deviceToken.toString());
                              Get.snackbar('Success','SignUp Successfully',
                                colorText: Colors.black,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                onTap: (SnackBar){
                                },
                              );

                              Get.to(CustomerLoginPage());

                            }).onError((error, stackTrace){
                              controller.loadingFunctionSignup(controller.loadingSignup);
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
                            child: controller.loadingSignup?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):const Text(
                              'SIGN Up',
                              style: TextStyle(
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
                  const Text("Already have an account?"),
                  SizedBox(
                    width: mq.width*0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>CustomerLoginPage()));
                        //Get.to(CustomerLoginPage());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color:Color.fromARGB(255, 15, 141, 6),
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
