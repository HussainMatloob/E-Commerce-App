import 'dart:io';
import 'package:e_commerce_app/controller/get_device_token_controller.dart';
import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:e_commerce_app/auths/Buyer_Account/email_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../services/services.dart';
import 'account_with_contact.dart';

class BuyerLoginPage extends StatefulWidget {
  const BuyerLoginPage({super.key});

  @override
  State<BuyerLoginPage> createState() => _BuyerLoginPageState();
}

class _BuyerLoginPageState extends State<BuyerLoginPage> {
  @override
  _handleGoogleBtnClick() {
    // Dialogs.showProgressBar(context);

    _signInWithGoogle().then((value) async {
      //Navigator.pop(context);
      if (value != null) {
        if ((await ServicesOrApis.userExists())) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeBottomBar()));
        } else {
          await ServicesOrApis.createUserWithGoogleAccount().then((value) {
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
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await ServicesOrApis.auth.signInWithCredential(credential);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.black,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        onTap: (SnackBar) {},
      );
      print("The error is"+e.toString());
      return null;
    }
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 141, 6),
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeBottomBar()));
            },
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
              size: 40,
            ),
          )),
      backgroundColor: Color.fromARGB(255, 15, 141, 6),
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.1,
          ),
          Container(
            child: Center(
              child: Text(
                "Easy Shopping",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.03,
          ),
          Container(
            height: mq.height*0.15,
            width: mq.width*0.31,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/Cart.jpg'),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            height: mq.height * 0.03,
          ),
          Container(
            child: Center(
              child: Text(
                "Register or Login with Mobile Number",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.03,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: mq.width * 0.02),
              height: mq.height * 0.07,
              width: mq.width * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [Text("+92  Enter Your Mobile Number")],
              ),
              // child: Text("+92  Enter Your Mobile Number"),
            ),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          Container(
            child: Center(
                child: TextButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerLoginPage()));
              },
              child: Text(
                "Login with email",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    decorationColor: Colors.white),
              ),
            )),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          Container(
            child: Center(
              child: Text(
                "-------- Or continue with --------",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          ElevatedButton.icon(
              onPressed: () async{
                final NotificationService deviceTokenController=Get.put(NotificationService());
                SharedPreferences sp=await SharedPreferences.getInstance();
                sp.setString('deviceToken', deviceTokenController.deviceToken.toString());
                _handleGoogleBtnClick();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  elevation: 1),
              icon: Image.asset(
                'images/google.png',
                height: mq.height * .03,
              ),
              label: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(text: 'Signin with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              )),
        ],
      ),
    );
  }
}
