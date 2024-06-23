class NotificationServices{

  FirebaseMessaging messaging=FirebaseMessaging.instance;
  void requestNotificationPermission() async{
    NotificationSettings settings=await messaging.requestPermission(
      akert:true,
      announcement:true,
      badge:true,
      carPlay:true,
      criticalAlert:true,
      provisional:true,
      sound:true
    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("User granted Permission");
    }
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("User provisional Permission");
    }
    else{
      print("User denied Permission");
    }
  }
}