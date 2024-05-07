import 'package:e_commerce_app/widgets/home_bottom_bar.dart';
import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),

        body: Container(
          child: Center(child: Text("No Any Chats",textAlign: TextAlign.center,),),
        ),
      );

  }
}
