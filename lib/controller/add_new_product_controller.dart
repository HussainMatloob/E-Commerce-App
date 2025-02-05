import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductController extends GetxController{
  String? selectedProductCategoryValue;
  String? selectedProductSaleValue;
  XFile? newImage;
  selectedProductCategory(String value){
    selectedProductCategoryValue=value;
    update();
  }

  selectedProductSale(String value){
    selectedProductSaleValue=value;
    update();
  }

  pickGallryImage(XFile image){
    newImage=image;
    update();
  }
}