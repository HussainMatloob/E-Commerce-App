import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFD6D6D6),
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(left: mq.width * 0.02, top: mq.height * 0.02),
            height: mq.height * 0.07,
            width: mq.width * 0.999,
            decoration: BoxDecoration(color: Colors.grey),
            child: Text(
              "Payment Methods",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white70),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Container(
              height: mq.height * 0.1, // Adjust these dimensions as needed
              width: mq.width * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Jazz cash logo vector.png"),
                  fit: BoxFit
                      .scaleDown, // Use BoxFit.scaleDown to make the image smaller
                ),
              ),
            ),
            title: Text(
              "JazzCash",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height*0.02,),
          ListTile(
            onTap: () {},
            leading: Container(
              height: mq.height * 0.1,
              width: mq.width * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/HBL Logo.png"),
                  fit:  BoxFit
                  .scaleDown, // Adjust this based on your requirement
                ),
              ),
            ),
            title: Text(
              "HBL Bank Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height*0.02,),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.calendar_month_rounded,size:  mq.width*0.097,),
            title: Text(
              "Installment",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height*0.02,),
          ListTile(
            onTap: () {},
            leading: Container(
              height: mq.height * 0.1,
              width: mq.width * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/EasyPasa.png"),
                  fit: BoxFit.scaleDown,  // Adjust this based on your requirement
                ),
              ),
            ),
            title: Text(
              "EasyPaisa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height*0.02,),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.local_atm_outlined,size: mq.width*0.097,),
            title: Text(
              "Cash On Delivery",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: mq.height*0.02,),
        ],
      ),
    );
  }
}
