import 'dart:io';

class AdHelper {
  //only for testing purpose
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      throw UnsupportedError("Unsupported Exception");
    }
  }
}
