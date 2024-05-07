import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/Screens/home_screen.dart';
import 'package:e_commerce_app/Screens/messages_screen.dart';
import 'package:e_commerce_app/auths/Buyer_Account/buyer_profile_page.dart';
import 'package:e_commerce_app/controller/utils_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Widget build(BuildContext context) {
    return GetBuilder<Util>(
      init: Util(),
      builder: (util){
      return WillPopScope(
        onWillPop: () async{
          if(util.selectedIndex==0){
            return true;
          }
          else{
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
              Icon(Icons.home,size: 25,),
              Icon(Icons.message,size: 25,),
              Icon(Icons.person,size: 25,),
            ],
            color: Colors.green,
            buttonBackgroundColor: Colors.green,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            //animationDuration: Duration(microseconds: 1000),
            onTap: (int index){
              util.bottomNavIndex(index);
            },
            //unselectedItemColor: Colors.green,
          ),
        ),
      );
    },
    );
  }
}



//return Scaffold(
//   body: _screens[_selectedIndex],
//   bottomNavigationBar: BottomNavigationBar(
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home, ),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.message ),
//         label: 'Messages',
//       ),
//
//       BottomNavigationBarItem(
//         icon: Icon(Icons.person),
//         label: 'Account',
//       ),
//
//     ],
//     currentIndex: _selectedIndex,
//     onTap: _onItemTapped,
//     selectedItemColor: Colors.green,
//     //unselectedItemColor: Colors.green,
//   ),
// );
