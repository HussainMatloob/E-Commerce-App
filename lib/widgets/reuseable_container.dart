 
import 'package:flutter/material.dart';

import '../main.dart';

class ReuseableContainer extends StatelessWidget {
  Icon differentIcons;
  String text;
  String countValue;
  Color containerColor;
  VoidCallback onTap;
  ReuseableContainer({super.key,required this.differentIcons,required this.text,
    required this.countValue,required this.containerColor,required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(mq.width*0.04),
        height: mq.height*0.2,
        width: mq.width*0.41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0XFFDCEDC8),
          border: Border.all(width: 1,color: containerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 5), // Only at the bottom
            ),
          ],
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(mq.width*0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                differentIcons,
                SizedBox(width: mq.width*0.02,),
                Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),

              ],),
          ),
          Center(child: Text(countValue,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),)
        ],),
      ),
    );
  }
}


