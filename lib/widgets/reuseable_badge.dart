import 'package:e_commerce_app/auths/Buyer_Account/buyer_login_page.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../Screens/cart_items_screen.dart';

class ReuseableBadge extends StatelessWidget {
  const ReuseableBadge({super.key});

  @override
  Widget build(BuildContext context) {

        return StreamBuilder(
          stream: ServicesOrApis.fireStore
              .collection('CountAndTotal')
              .doc(ServicesOrApis.user?.uid)
              .snapshots(),
          builder: (context,snapshot){
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if ( data != null && data.isNotEmpty) {
              final newData = data;
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
                child:
                Center(
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                        newData['Counter'].toString(),
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
            }
            else{
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
                child:
                Center(
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent: Text(
                        0.toString(),
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
            }
            }
          else{
           // final newData = data;
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
              child:
              Center(
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  badgeContent: Text(
                      0.toString(),
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
          }
          },

        );
  }
}
