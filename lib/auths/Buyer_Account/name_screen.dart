import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:e_commerce_app/auths/Buyer_Account/forgot_with_contact.dart';
import 'package:e_commerce_app/models/user_profile.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../services/services.dart';
import 'buyer_profile_page.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var passwordData;

  @override
  String? nameValidate(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your Name";
    }
    return null;
  }

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
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Form(
        key: logKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: mq.height * 0.05,
            ),
            FutureBuilder(
              future: ServicesOrApis.userExists(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(); // Display a loading indicator while waiting for the result
                }
                else{
                  if(!snapshot.hasError && snapshot.data == false){
                    return  Text(
                      "Create an account",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  }
                  else{
                    return Container();
                  }
                }

              },

            ),
                FutureBuilder(
                  future: ServicesOrApis.userExists(),
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // Display a loading indicator while waiting for the result
                    }
                    else{
                      if(!snapshot.hasError && snapshot.data == false){
                        return Text("Please enter your  name and set up a password");
                      }
                      else{
                        return Text("Please enter your password");
                      }
                    }

                  },

                ),

            SizedBox(
              height: mq.height * 0.02,
            ),

                    // If user doesn't exist, display TextFormField
                 StreamBuilder(
                   stream: ServicesOrApis.currentUser(),
                   builder: (context,snapshot){
                     if(snapshot.hasData){
                       final data=snapshot.data?.data();
                       if(data!=null&&data.isNotEmpty){
                       return Container();
                       }
                        else{
                         return TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           controller: nameController,
                           decoration: InputDecoration(
                             focusedBorder: const OutlineInputBorder(
                               borderSide: BorderSide(color: Color(0xffEE7EB)),
                             ),
                             enabledBorder: const OutlineInputBorder(
                               borderSide: BorderSide(color: Color(0xffEE7EB)),
                             ),
                             hintText: 'Name',
                             filled: true,
                             fillColor: const Color(0xffFBF9FA),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                           ),
                           validator: nameValidate,
                         );
                       }
                     }
                     else{
                       return Container();
                     }
                   },
                 ),

            SizedBox(
              height: mq.height * 0.02,
            ),
                StreamBuilder(
                  stream: ServicesOrApis.currentUser(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      final data=snapshot.data?.data();
                      if(data!=null&&data.isNotEmpty){
                        passwordData=UserProfile.fromJson(data);
                        var Password=passwordData.password;
                        return TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon:
                              Icon(Icons.lock, color: Color(0xffF323F4B)),
                              suffixIcon: Icon(Icons.visibility_off_outlined),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffEE7EB)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xffEE7EB)),
                              ),
                              hintText: 'Password',
                              filled: true,
                              fillColor: Color(0xffFBF9FA),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty){
                                return "Please Enter Password";
                              }
                              if (value != Password) {
                                return "Your Password Incorrect";
                              }
                            });
                      }
                      else{
                       return TextFormField(
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
                        );
                      }
                    }
                    else{
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: mq.height * 0.01,
                ),
                FutureBuilder(
                  future: ServicesOrApis.userExists(),
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(); // Display a loading indicator while waiting for the result
                    }
                    else{
                      if(!snapshot.hasError && snapshot.data == false){
                        return Container();
                      }
                      else{
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotContactPassword()));
                                },
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Rubik Regular',
                                      color: Colors.black),
                                )),
                          ],
                        );
                      }
                    }

                  },

                ),


            SizedBox(
              height: mq.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (logKey.currentState!.validate()) {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString('name', nameController.text);
                  sp.setString('password', passwordController.text);
                  // sp.setBool('Boolean', true);

                  // String? Name = sp.getString('name');
                  // print("Myname is:" + Name.toString());

                  if ((await ServicesOrApis.userExists())) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeBottomBar()));
                  } else {
                    await ServicesOrApis.createUser().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeBottomBar()));
                    });
                  }
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
          ]),
        ),
      ),
    );
  }
}
