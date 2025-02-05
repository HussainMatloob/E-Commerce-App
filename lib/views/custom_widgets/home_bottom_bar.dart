import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../utils/ad_helper.dart';
import '../screens/home_screen.dart';
import '../screens/messages_screen.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<Widget> _screens = [
    HomeScreen(),
    MessagesScreen(),
    BuyerProfilePage(),
  ];
  InterstitialAd? _interstitialAd;
  int numMaxAdAttempt=0;
  void _createInterstitialAd(){
     InterstitialAd.load(adUnitId: AdHelper.interstitialAdUnitId,
         request:AdRequest(),
         adLoadCallback:InterstitialAdLoadCallback(onAdLoaded:(ad){
           _interstitialAd=ad;
           numMaxAdAttempt=0;
           _interstitialAd?.setImmersiveMode(true);
         },onAdFailedToLoad:(error){
         log("ad failed$error");
         numMaxAdAttempt+=1;
         _interstitialAd=null;
         if(numMaxAdAttempt<3){
           _createInterstitialAd();
         }
         }
         ));
  }

  void _showInterstitialAd(){
    if(_interstitialAd==null){
      return;
    }
     _interstitialAd?.fullScreenContentCallback=FullScreenContentCallback(
       onAdShowedFullScreenContent: (ad){
         log('ad successfully show');
       },
       onAdWillDismissFullScreenContent: (ad){
        ad.dispose();
        _createInterstitialAd();
       },
       onAdFailedToShowFullScreenContent:(ad,error){
         ad.dispose();
         _createInterstitialAd();
       } ,
     );
    _interstitialAd?.show();
    _interstitialAd=null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _interstitialAd?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Util>(
      init: Util(),
      builder: (util) {
        return WillPopScope(
          onWillPop: () async {
            if (util.selectedIndex == 0) {
              return true;
            } else {
              util.setBottomNavIndex();
              return false;
            }

            //return util.selectedIndex==0;
            return false;
          },
          child: Scaffold(
            body: _screens[util.selectedIndex],
            bottomNavigationBar: CurvedNavigationBar(
              index: util.selectedIndex,
              height: 50,
              items: [
                Icon(
                  Icons.home,
                  size: 25,
                ),
                Icon(
                  Icons.message,
                  size: 25,
                ),
                Icon(
                  Icons.person,
                  size: 25,
                ),
              ],
              color: Colors.green,
              buttonBackgroundColor: Colors.green,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              //animationDuration: Duration(microseconds: 1000),
              onTap: (int index) {
                util.bottomNavIndex(index);
                _showInterstitialAd();
              },
              //unselectedItemColor: Colors.green,
            ),
          ),
        );
      },
    );
  }
}
