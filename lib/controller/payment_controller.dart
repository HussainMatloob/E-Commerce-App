import 'package:get/get.dart';

class SelectPaymentMethod extends GetxController{

  String payBy="";

  bool selectJazCash=false;
  bool selectHBL=false;
  bool selectInstalment=false;
  bool selectEasyPais=false;
  bool selectCashOnDelivery=false;

  payMethod(String method){
    payBy=method;
  }

 payJazCash(bool value){
   selectJazCash=value;
   selectHBL=false;
   selectInstalment=false;
   selectEasyPais=false;
   selectCashOnDelivery=false;
   update();
 }
 payHBl(bool value){
   selectHBL=value;
    selectJazCash=false;
    selectInstalment=false;
    selectEasyPais=false;
    selectCashOnDelivery=false;
   update();
 }
 payInStallment(bool value){
   selectInstalment=value;
   selectJazCash=false;
   selectHBL=false;
   selectEasyPais=false;
   selectCashOnDelivery=false;
   update();
 }
 payEasyPais(bool value){
   selectEasyPais=value;
   selectJazCash=false;
   selectHBL=false;
   selectInstalment=false;
   selectCashOnDelivery=false;
   update();
 }
 payCashOnDelivery(bool value){
   selectCashOnDelivery=value;
   selectJazCash=false;
   selectHBL=false;
   selectInstalment=false;
   selectEasyPais=false;
   update();
 }
}