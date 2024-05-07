import 'dart:async';
import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white60,
          statusBarColor: Colors.white60));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>HomeBottomBar()));

     // context.go('/home');

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Image.asset('images/Cart.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
