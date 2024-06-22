import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'otp_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();
  final TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // contactController.text = '+92';
  }

  String? contactValidate(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter Phone number";
    }
    bool contactRegex = RegExp(r'^[0-9]{10}$').hasMatch(value);

    if (contactRegex == false) {
      return "Please enter valid number";
    }
    return null;
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: logKey,
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your mobile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("number",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: contactController,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: mq.width * 0.02),
                          Icon(
                            Icons.phone,
                            color: Color(0xffF323F4B),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '+92',
                            style: TextStyle(
                                color: Color(0xffF323F4B), fontSize: 18),
                          ),
                          SizedBox(width: mq.width * 0.02),
                        ],
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEE7EB)),
                      ),
                      hintText: 'Enter Phone Number',
                      filled: true,
                      fillColor: Color(0xffFBF9FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: contactValidate,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mq.height * 0.05,
            ),
            InkWell(
              onTap: () async {
                if (logKey.currentState!.validate()) {
                  try {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('contact', "+92"+contactController.text);

                    await FirebaseAuth.instance
                        .verifyPhoneNumber(
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException ex) {},
                            codeSent:
                                (String VarificationId, int? resendtoken) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                          varificationId: VarificationId)));
                            },
                            codeAutoRetrievalTimeout:
                                (String varificationId) {},
                            phoneNumber: "+92"+contactController.text.toString());

                  } catch (e) {
                    print(e);
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
