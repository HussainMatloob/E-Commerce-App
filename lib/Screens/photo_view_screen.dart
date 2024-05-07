import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../models/product_details.dart';
class PhotoViewer extends StatefulWidget {
  ProductDetails productDetails;
   PhotoViewer({super.key,required this.productDetails});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child:  Container(
          child: Stack(
            children: [
              PhotoView(
                imageProvider: NetworkImage(
                  widget.productDetails.image.toString(),
                ),

                minScale: PhotoViewComputedScale.contained, // Set minScale to cover the entire container
              ),
              Positioned(
                top: 20, // Adjust as needed
                right: 20, // Adjust as needed
                child: IconButton(
                  icon: Icon(Icons.close,color: Colors.white,), // You can replace this with your custom close icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
