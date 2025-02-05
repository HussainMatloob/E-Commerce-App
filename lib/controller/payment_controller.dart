import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_app/constants/key_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class PaymentMethodsController extends GetxController {
  String payBy = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool selectJazCash = false;
  bool selectEasyPais = false;
  bool selectStripe = false;
  bool selectCardPayment = false;
  bool selectCashOnDelivery = false;

  payMethod(String method) {
    payBy = method;
    update();
  }

  payJazCash(bool value) {
    selectJazCash = value;
    selectStripe = false;
    selectCardPayment = false;
    selectEasyPais = false;
    selectCashOnDelivery = false;
    update();
  }

  payEasyPais(bool value) {
    selectEasyPais = value;
    selectJazCash = false;
    selectStripe = false;
    selectCardPayment = false;
    selectCashOnDelivery = false;
    update();
  }

  payStripe(bool value) {
    selectStripe = value;
    selectJazCash = false;
    selectCardPayment = false;
    selectEasyPais = false;
    selectCashOnDelivery = false;
    update();
  }

  payWithCard(bool value) {
    selectCardPayment = value;
    selectJazCash = false;
    selectStripe = false;
    selectEasyPais = false;
    selectCashOnDelivery = false;
    update();
  }

  payCashOnDelivery(bool value) {
    selectCashOnDelivery = value;
    selectJazCash = false;
    selectStripe = false;
    selectCardPayment = false;
    selectEasyPais = false;
    update();
  }

  void paymentMethod(BuildContext context) {
    try {
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom // Set the custom style
        ..textColor = Colors.white // Color of the loading status text
        ..indicatorColor = Colors.white // Color of the loading indicator
        ..progressColor = Colors
            .white // Progress color of the loading indicator (if applicable)
        ..backgroundColor =
            Colors.green // Background color of the loading indicator
        ..maskColor = Colors.red; // Mask color of the loading (if applicable)
      EasyLoading.show(status: 'Please Wait...');
      ServicesOrApis.buyProducts(
              payBy,
              nameController.text,
              contactController.text,
              cityController.text,
              addressController.text)
          .then((value) => {
                if (value == true)
                  {
                    EasyLoading.dismiss(),
                    Get.snackbar(
                      'Success',
                      'Your order Confirmed',
                      colorText: Colors.black,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.TOP,
                      onTap: (SnackBar) {},
                    ),
                    Navigator.pop(context),
                  }
                else
                  {
                    EasyLoading.dismiss(),
                    Get.snackbar(
                      '',
                      'Please must Add anyone item to your cart',
                      colorText: Colors.black,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.TOP,
                      onTap: (SnackBar) {},
                    ),
                  }
              });
    } catch (error) {
      EasyLoading.dismiss();
      print("Error $error");
    }
  }

  PaymobResponse? response;

  void initializePaymentMethod() {
    PaymobPakistan.instance.initialize(
      apiKey: "{YOUR API KEY HERE}",
      integrationID: 123456,
      iFrameID: 123456,
      jazzcashIntegrationId: 123456,
      easypaisaIntegrationID: 123456,
    );
  }

  /* ----------------------------------------------------------------- */
  /*                    jazz cash payment method                       */
  /* ----------------------------------------------------------------- */
  Future<void> payWithJazzCash(BuildContext context) async {
    try {
      PaymentInitializationResult result =
          await PaymobPakistan.instance.initializePayment(
        currency: "PKR",
        amountInCents: "100",
      );
      String authToken = result.authToken;
      int orderID = result.orderID;

      // Make the payment using Jazzcash
      PaymobPakistan.instance.makePayment(context,
          currency: "PKR",
          amountInCents: "100",
          paymentType: PaymentType.jazzcash,
          authToken: authToken,
          orderID: orderID, onPayment: (receivedResponse) {
        response = receivedResponse;
        update();
      });
    } catch (err) {
      print("Error: $err");
    }
  }

  /* ----------------------------------------------------------------- */
  /*                   Easy paisa payment method                       */
  /* ----------------------------------------------------------------- */
  Future<void> payWithEasyPaisa(BuildContext context) async {
    try {
      PaymentInitializationResult result =
          await PaymobPakistan.instance.initializePayment(
        currency: "PKR",
        amountInCents: "100",
      );
      String authToken = result.authToken;
      int orderID = result.orderID;
      // Make the payment using Easypaisa
      PaymobPakistan.instance.makePayment(
        context,
        currency: "PKR",
        amountInCents: "100",
        billingData: PaymobBillingData(
          email: "test@test.com",
          firstName: "Arshman",
          lastName: "Afzal",
          phoneNumber: "+921234567890",
          apartment: "NA",
          building: "NA",
          city: "NA",
          country: "Pakistan",
          floor: "NA",
          postalCode: "NA",
          shippingMethod: "Online",
          state: "NA",
          street: "NA",
        ),
        paymentType: PaymentType.easypaisa,
        onPayment: (receivedResponse) {
          response = receivedResponse;
          update();
        },
        authToken: authToken, // Ensure authToken is passed correctly
        orderID: orderID, // Ensure orderID is passed correctly
      );
    } catch (err) {
      print("Error: $err");
    }
  }

  /* ----------------------------------------------------------------- */
  /*                        through card payment                       */
  /* ----------------------------------------------------------------- */
  Future<void> paymentWithCards(BuildContext context) async {
    try {
      PaymentInitializationResult result =
          await PaymobPakistan.instance.initializePayment(
        currency: "PKR",
        amountInCents: "100",
      );
      String authToken = result.authToken;
      int orderID = result.orderID;

      // Make the payment using Card
      PaymobPakistan.instance.makePayment(
        context,
        currency: "PKR",
        amountInCents: "100",
        paymentType: PaymentType.card,
        onPayment: (receivedResponse) {
          response = receivedResponse;
          update();
        },
        billingData: PaymobBillingData(
          email: "test@test.com",
          firstName: "Arshman",
          lastName: "Afzal",
          phoneNumber: "+921234567890",
          apartment: "NA",
          building: "NA",
          city: "NA",
          country: "Pakistan",
          floor: "NA",
          postalCode: "NA",
          shippingMethod: "Online",
          state: "NA",
          street: "NA",
        ),
        authToken: authToken, // Ensure authToken is passed correctly
        orderID: orderID, // Ensure orderID is passed correctly
      );
    } catch (err) {
      print("Error: $err");
    }
  }

  /* ----------------------------------------------------------------- */
  /*                             Stripe Payment                        */
  /* ----------------------------------------------------------------- */
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent("1000", "PKR");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: true,
        merchantDisplayName: 'The Business Partners',
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'PK', currencyCode: 'PKR', testEnv: true),
      ));

      await displayPaymentSheet();
    } catch (e) {
      log(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'currency': currency,
        'amount': ((int.parse(amount) * 100)).toString(),
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${KeyConstants.secret_Key}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await Stripe.instance.confirmPaymentSheetPayment();
      });
      paymentIntent = null;
    } on StripeException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
