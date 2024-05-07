import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/splash_screen.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override

   Widget build(BuildContext context)
  {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}