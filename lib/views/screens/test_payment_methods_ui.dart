import 'package:e_commerce_app/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymentMethodsController paymentMethodsController =
      Get.put(PaymentMethodsController());
  @override
  void initState() {
    super.initState();
    // Initialize Paymob with your actual API keys and IDs (these values should be replaced once available)
    paymentMethodsController.initializePaymentMethod();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
    // return GetBuilder<PaymentMethodsController>(
    //   init: PaymentMethodsController(),
    //   builder: (paymentMethodsController) {
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Paymob'),
    //       ),
    //       body: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             Image.network('https://paymob.pk/images/paymobLogo.png'),
    //             const SizedBox(height: 24),
    //             if (paymentMethodsController.response != null)
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //                   Text(
    //                       "Success ==> ${paymentMethodsController.response?.success}"),
    //                   const SizedBox(height: 8),
    //                   Text(
    //                       "Transaction ID ==> ${paymentMethodsController.response?.transactionID}"),
    //                   const SizedBox(height: 8),
    //                   Text(
    //                       "Message ==> ${paymentMethodsController.response?.message}"),
    //                   const SizedBox(height: 8),
    //                   Text(
    //                       "Response Code ==> ${paymentMethodsController.response?.responseCode}"),
    //                   const SizedBox(height: 16),
    //                 ],
    //               ),
    //             Column(
    //               children: [
    //                 /* ----------------------------------------------------------------- */
    //                 /*                    jazz cash payment method                       */
    //                 /* ----------------------------------------------------------------- */
    //
    //                 ElevatedButton(
    //                   child: const Text('Pay with Jazzcash'),
    //                   onPressed: () async {
    //                     paymentMethodsController.payWithJazzCash(context);
    //                   },
    //                 ),
    //
    //                 /* ----------------------------------------------------------------- */
    //                 /*                   Easy paisa payment method                       */
    //                 /* ----------------------------------------------------------------- */
    //
    //                 ElevatedButton(
    //                   child: const Text('Pay with Easypaisa'),
    //                   onPressed: () async {
    //                     paymentMethodsController.payWithEasyPaisa(context);
    //                   },
    //                 ),
    //
    //                 /* ----------------------------------------------------------------- */
    //                 /*                        through card payment                       */
    //                 /* ----------------------------------------------------------------- */
    //                 ElevatedButton(
    //                   child: const Text('Pay with Card'),
    //                   onPressed: () async {
    //                     paymentMethodsController.paymentWithCardssssss(context);
    //                   },
    //                 ),
    //
    //                 /* ----------------------------------------------------------------- */
    //                 /*                            through  Stripe                        */
    //                 /* ----------------------------------------------------------------- */
    //                 ElevatedButton(
    //                   child: const Text('Stripe Payment'),
    //                   onPressed: () async {
    //                     paymentMethodsController.makePayment();
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
