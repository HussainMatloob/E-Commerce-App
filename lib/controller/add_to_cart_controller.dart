import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToCartController extends GetxController {
  int counter = 0;
  int totalAmount = 0;

  void setPrefDetail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('count', counter);
    sp.setInt('Total', totalAmount);
  }

  void getPrefDetail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    counter = sp.getInt('count') ?? 0;
    totalAmount = sp.getInt('Total') ?? 0;
    update();
  }

  void addCounter() {
    counter++;
    setPrefDetail();
    update();
  }

  void lessCounter() {
    counter--;
    setPrefDetail();
    update();
  }

  int getCounterValue() {
    getPrefDetail();
    return counter;
  }

  void addTotal(int total) {
    totalAmount += total;
    setPrefDetail();
    update();
  }

  void lessTotal(int total) {
    totalAmount = totalAmount - total;
    setPrefDetail();
    update();
  }

  int getTotal() {
    getPrefDetail();
    return totalAmount;
  }
}
