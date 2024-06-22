import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce_app/controller/add_new_product_controller.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  @override

  TextEditingController productNameController=TextEditingController();
  TextEditingController productPriceController=TextEditingController();
  TextEditingController productQuantityController=TextEditingController();
  TextEditingController productDetailsController=TextEditingController();
  TextEditingController productSaleController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productSaleController.text="0";
  }

  final List<String>  productCategoryItems = [
    "Women's Fashion",
    "Men's Fashion",
    'Watches',
    'Man Shoes',
  ];
  final List<String> productSalesItems = [
    "Sale",
    "Not sale",
  ];

  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Product'),
        ),
        body: GetBuilder<AddNewProductController>
          (init: AddNewProductController(),
          builder: (addNewProductController){
         return Form(
           key: formKey,
           child: Column(
             children: [
               Expanded(
                 child: SingleChildScrollView(
                   physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                   child: Padding(
                     padding:  EdgeInsets.only(top: mq.height * 0.03,
                         right: mq.width * 0.03,left: mq.width * 0.03),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Select product category",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16),),
                         SizedBox(height: mq.height*0.015),
                         DropdownButtonHideUnderline(
                           child: DropdownButton2<String>(
                             isExpanded: true,
                             hint: Row(
                               children: [
                                 Icon(
                                   Icons.list,
                                   size: 16,
                                   color: Colors.white,
                                 ),
                                 SizedBox(
                                   width: mq.width * 0.03,
                                 ),
                                 Expanded(
                                   child: Text(
                                     'Select Category',
                                     style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white,
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                 ),
                               ],
                             ),
                             items: productCategoryItems
                                 .map((String item) => DropdownMenuItem<String>(
                               value: item,
                               child: Text(
                                 item,
                                 style: const TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ))
                                 .toList(),
                             value: addNewProductController.selectedProductCategoryValue,
                             onChanged: (value) {
                               addNewProductController.selectedProductCategory(value.toString());
                             },
                             buttonStyleData: ButtonStyleData(
                               height: mq.height * 0.07,
                               width: mq.width * 0.7,
                               padding: EdgeInsets.only(
                                   left: mq.width * 0.03, right: mq.width * 0.04),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 border: Border.all(
                                   color: Colors.black26,
                                 ),
                                 color: Colors.green,
                               ),
                               elevation: 2,
                             ),
                             iconStyleData: const IconStyleData(
                               icon: Icon(
                                 Icons.arrow_forward_ios_outlined,
                               ),
                               iconSize: 14,
                               iconEnabledColor: Colors.white,
                               iconDisabledColor: Colors.grey,
                             ),
                             dropdownStyleData: DropdownStyleData(
                               maxHeight: mq.height * 0.2,
                               width: null, // Let it automatically adjust to button width
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 color: Colors.green,
                               ),
                               offset: Offset(0, 0),// Adjust based on your need, initially try (0, 0)
                               scrollbarTheme: ScrollbarThemeData(
                                 radius: const Radius.circular(40),
                                 thickness: MaterialStateProperty.all(6),
                                 thumbVisibility: MaterialStateProperty.all(true),
                               ),
                             ),
                             menuItemStyleData: MenuItemStyleData(
                               height: mq.height * 0.06,
                               padding: EdgeInsets.only(
                                   left: mq.width * 0.03, right: mq.width * 0.1),
                             ),
                           ),
                         ),


                         SizedBox(height: mq.height*0.015),
                         Text("Select product sale or not",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16),),
                         SizedBox(height: mq.height*0.015),
                         DropdownButtonHideUnderline(
                           child: DropdownButton2<String>(
                             isExpanded: true,
                             hint: Row(
                               children: [
                                 Icon(
                                   Icons.list,
                                   size: 16,
                                   color: Colors.white,
                                 ),
                                 SizedBox(
                                   width: mq.width * 0.03,
                                 ),
                                 Expanded(
                                   child: Text(
                                     'Sele or Not',
                                     style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white,
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                 ),
                               ],
                             ),
                             items: productSalesItems
                                 .map((String item) => DropdownMenuItem<String>(
                               value: item,
                               child: Text(
                                 item,
                                 style: const TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ))
                                 .toList(),
                             value: addNewProductController.selectedProductSaleValue,
                             onChanged: (value) {
                               addNewProductController.selectedProductSale(value.toString());
                             },
                             buttonStyleData: ButtonStyleData(
                               height: mq.height * 0.07,
                               width: mq.width * 0.7,
                               padding: EdgeInsets.only(
                                   left: mq.width * 0.03, right: mq.width * 0.04),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 border: Border.all(
                                   color: Colors.black26,
                                 ),
                                 color: Colors.green,
                               ),
                               elevation: 2,
                             ),
                             iconStyleData: const IconStyleData(
                               icon: Icon(
                                 Icons.arrow_forward_ios_outlined,
                               ),
                               iconSize: 14,
                               iconEnabledColor: Colors.white,
                               iconDisabledColor: Colors.grey,
                             ),
                             dropdownStyleData: DropdownStyleData(
                               maxHeight: mq.height * 0.2,
                               width: null, // Let it automatically adjust to button width
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 color: Colors.green,
                               ),
                               offset: Offset(0, 0),// Adjust based on your need, initially try (0, 0)
                               scrollbarTheme: ScrollbarThemeData(
                                 radius: const Radius.circular(40),
                                 thickness: MaterialStateProperty.all(6),
                                 thumbVisibility: MaterialStateProperty.all(true),
                               ),
                             ),
                             menuItemStyleData: MenuItemStyleData(
                               height: mq.height * 0.06,
                               padding: EdgeInsets.only(
                                   left: mq.width * 0.03, right: mq.width * 0.1),
                             ),
                           ),
                         ),

                         SizedBox(height: mq.height*0.04),


                         InkWell(
                             onTap: () async{

                               ImagePicker picker = ImagePicker();
                               XFile? image = await picker.pickImage(
                                   source: ImageSource.gallery, imageQuality: 80);
                               if (image != null) {
                                 print(
                                     'Image Path: ${image?.path} -- MimeType: ${image!.mimeType}');
                                 addNewProductController.pickGallryImage(image);
                                 String im=addNewProductController.newImage.toString();
                                 print("New Image is $im");
                               }
                             },
                           child: Container(
                             height: mq.height * 0.2,
                             width: mq.width * 0.41,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Color(0XFFE0E0E0),
                               border: Border.all(width: 1, color: Colors.white),
                             ),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: addNewProductController.newImage == null
                                   ? CachedNetworkImage(
                                 fit: BoxFit.cover,
                                 imageUrl: "", // Provide a default URL if you want to show something
                                 errorWidget: (context, url, error) => Icon(
                                   Icons.image,
                                   size: 50,
                                   color: Colors.grey,
                                 ),
                               )
                                   : Image.file(
                                 File(addNewProductController.newImage!.path.toString()),
                                 fit: BoxFit.cover,
                               ),
                             ),
                           ),
                           ),

                         SizedBox(height: mq.height*0.04),
                         TextFormField(
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           controller: productNameController,
                           decoration: InputDecoration(
                               hintText: "Product name",
                               border: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Colors.grey
                                 ),
                               )
                           ),
                          validator: (value){
                             if(value==null||value.trim().isEmpty){
                               return "Please must fill field";
                             }
                          },
                         ),


                         SizedBox(height: mq.height*0.03),
                         TextFormField(
                           controller: productPriceController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           keyboardType: TextInputType.number,
                           inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly, // Allow only digits
                           ],
                           decoration: InputDecoration(
                               hintText: "Product price",
                               border: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Colors.grey
                                 ),
                               )
                           ),
                           validator: (value){
                             if(value==null||value.trim().isEmpty){
                               return "Please must fill field";
                             }
                           },
                         ),


                         SizedBox(height: mq.height*0.03),
                         TextFormField(
                           controller: productQuantityController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           keyboardType: TextInputType.number,
                           inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly, // Allow only digits
                           ],
                           decoration: InputDecoration(
                               hintText: "Product quantity",
                               border: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Colors.grey
                                 ),
                               )
                           ),
                           validator: (value){
                             if(value==null||value.trim().isEmpty){
                               return "Please must fill field";
                             }
                           },
                         ),


                         SizedBox(height: mq.height*0.03),
                         TextFormField(
                           controller: productDetailsController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           keyboardType: TextInputType.multiline,
                           maxLines: null,
                           decoration: InputDecoration(
                               hintText: "Product Details",
                               border: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Colors.grey
                                 ),
                               )
                           ),
                           validator: (value){
                             if(value==null||value.trim().isEmpty){
                               return "Please must fill field";
                             }
                           },
                         ),


                         SizedBox(height: mq.height*0.03),
                         addNewProductController.selectedProductSaleValue=="Sale"? TextFormField(
                           controller: productSaleController,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           keyboardType: TextInputType.number,
                           inputFormatters: [
                             FilteringTextInputFormatter.digitsOnly, // Allow only digits
                           ],
                           decoration: InputDecoration(
                               hintText: "Product sale price",
                               border: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                     color: Colors.grey
                                 ),
                               )
                           ),
                           validator: (value){
                             if(value==null||value.trim().isEmpty){
                               return "Please must fill field";
                             }
                           },
                         ):Container(),

                         SizedBox(height: mq.height*0.05),

                       ],
                     ),
                   ),
                 ),
               ),
               InkWell(
                 onTap: (){
                   if(addNewProductController.selectedProductCategoryValue==null){
                     Get.snackbar(
                        "",
                       'Please must select category',
                       icon: Icon(Icons.lock_reset, color: Colors.white),
                       colorText: Colors.black,
                       backgroundColor: Colors.green,
                       snackPosition: SnackPosition.TOP,
                       onTap: (SnackBar) {},
                     );

                   }
                  else if(addNewProductController.selectedProductSaleValue==null){
                     Get.snackbar(
                       "",
                       'Please must select sale or not',
                       icon: Icon(Icons.lock_reset, color: Colors.white),
                       colorText: Colors.black,
                       backgroundColor: Colors.green,
                       snackPosition: SnackPosition.TOP,
                       onTap: (SnackBar) {},
                     );
                   }
                  else if(addNewProductController.newImage==null){
                   Get.snackbar(
                   "",
                   'Please must select an image',
                   icon: Icon(Icons.lock_reset, color: Colors.white),
                   colorText: Colors.black,
                   backgroundColor: Colors.green,
                   snackPosition: SnackPosition.TOP,
                   onTap: (SnackBar) {},
                   );
                   }
                  else{
                        if(formKey.currentState!.validate())
                        {

                          ServicesOrApis.addNewProductDetails(addNewProductController.selectedProductCategoryValue.toString(),addNewProductController.selectedProductSaleValue.toString()
                          ,File(addNewProductController.newImage!.path.toString()),productNameController.text,productPriceController.text,productQuantityController.text,productDetailsController.text,
                            productSaleController.text
                          );
                        }
                   }
                 },
                 child: Container(
                   height: mq.height*0.07,
                   width: mq.width*0.6,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                   color: Colors.green,
                 ),
                 child: Center(child: Text("Add",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                 ),
               ),
             ],
           ),
         );
          },
        ),
      ),
    );
  }
}
