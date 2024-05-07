import 'package:e_commerce_app/Screens/cart_items_screen.dart';

import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:e_commerce_app/Screens/messages_screen.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PersistNavBar extends StatefulWidget {
  const PersistNavBar({super.key});

  @override
 State<PersistNavBar> createState() => _PersistNavBarState();
}

class _PersistNavBarState extends State<PersistNavBar> {
  PersistentTabController _controller = PersistentTabController();
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.text_bubble_fill),
        title: ("Messages"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Account"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      MessagesScreen(),
      CartItems(),
      BuyerProfilePage(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Util>(
      init: Util(),
      builder: (util) {
        return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(1),
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style1,
          );

      }
    ); //
  }
}



