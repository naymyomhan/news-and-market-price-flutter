import 'dart:io';

class AdsHelper {
  //Banner
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return "ca-app-pub-3940256099942544/1033173712";
  //   } else if (Platform.isIOS) {
  //     return "ca-app-pub-3940256099942544/4411468910";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     //TEST
  //     return "ca-app-pub-3940256099942544/5224354917";
  //     //PRODUCTION
  //     // return "ca-app-pub-********";
  //   } else if (Platform.isIOS) {
  //     //TEST
  //     return "ca-app-pub-3940256099942544/1712485313";
  //     //PROCUCTION
  //     // return "ca-app-pub-********";
  //   } else {
  //     throw UnsupportedError("Unsupported platform");
  //   }
  // }

  static String get rewardedInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5354046379";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/6978759866";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
