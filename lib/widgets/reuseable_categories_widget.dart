import 'package:flutter/material.dart';
import '../main.dart';

class CategoriesWidget extends StatefulWidget {
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback onTap;
  final String buttonText;
    CategoriesWidget({super.key,required this.headingSubtitle,
    required this.headingTitle,required this.onTap,required this.buttonText});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return   Padding(
      padding: EdgeInsets.only(
          left: mq.width * 0.03,
          right: mq.width * 0.03,
          top: mq.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                 widget.headingTitle,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(widget.headingSubtitle)
            ],
          ),
           InkWell(
                onTap:widget.onTap,
                child: Container(
                  height: mq.height * 0.04,
                  width: mq.width * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.red)),
                  child:   Center(
                      child: Text(
                        widget.buttonText,
                        style: TextStyle(color: Colors.red),
                      )),
                ),
              ),
        ],
      ),
    );
  }
}
