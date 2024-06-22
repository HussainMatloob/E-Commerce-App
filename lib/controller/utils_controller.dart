import 'package:get/get.dart';
class Util extends GetxController{

  bool obsecurePasswordSignup=true;
  bool forgotPasswordLoading=false;
  int  _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  bool favourite=false;



  ObsecureSignup(bool a){
    obsecurePasswordSignup=!a;
    update();
  }

  bool loadingSignup=false;
  loadingFunctionSignup(bool load){
    loadingSignup=!load;
    update();
  }

  bool obsecurePasswordLogin=true;

  ObsecureLogin(bool a){
    obsecurePasswordLogin=!a;
    update();
  }

  bool loadingLogin=false;
  loadingFunctionLogin(bool load){
    loadingLogin=!load;
    update();
  }

  bool obsecureChangePasswordOld=true;

  ObsecureOld(bool a){
    obsecureChangePasswordOld=!a;
    update();
  }

  bool obsecureChangePasswordNew=true;

  ObsecureNew(bool a){
    obsecureChangePasswordNew=!a;
    update();
  }

  bool loadingChangePassword=false;
  loadingChange(bool load){
    loadingChangePassword=!load;
    update();
  }

  forGotLoading(bool value){
    forgotPasswordLoading=value;
    update();
  }

  bottomNavIndex(int index)
  {
    _selectedIndex=index;
    update();
  }
  setBottomNavIndex(){
    _selectedIndex=0;
    update();
  }
  favouriteUpdate(){
    favourite=!favourite;
    update();
  }
}