import 'package:e_commerce_app/auths/Buyer_Account/buyer_login_page.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import '../Screens/cart_items_screen.dart';
import '../controller/add_to_cart_controller.dart';

class ReuseableBadge extends StatelessWidget {
  const ReuseableBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddToCartController>(
      init: AddToCartController(),
      builder: (addToCartController) {

        return InkWell(
          onTap: () {
            if(ServicesOrApis.user==null){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>BuyerLoginPage()));
            }
            else{
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartItems()));
            }
          },
          child: Center(
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              badgeContent: Text(
                  addToCartController.getCounterValue().toString(),
                  style: TextStyle(color: Colors.white)),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 2),
                colorChangeAnimationDuration: Duration(seconds: 3),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.red,
                //shape: badges.BadgeShape.square,
                borderRadius: BorderRadius.circular(8),
                //borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }
}
