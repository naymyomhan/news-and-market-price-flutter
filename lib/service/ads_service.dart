import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:news_app/helpers/ads_helper.dart';

class AdsService {
  // TODO: Add _rewardedAd
  // static RewardedAd? rewardedAd;

  //TODO: Add_rewardedInterstitialAd
  static RewardedInterstitialAd? rewardedInterstitialAd;

  // TODO: Implement _loadRewardedAd()
  // static void loadRewardedAd() {
  //   RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdShowedFullScreenContent: (RewardedAd ad) {
  //             //
  //           },
  //           onAdDismissedFullScreenContent: (ad) {
  //             ad.dispose();
  //             rewardedAd = null;
  //             loadRewardedAd();
  //           },
  //           onAdFailedToShowFullScreenContent: (ad, error) {
  //             ad.dispose();
  //             rewardedAd = null;
  //             loadRewardedAd();
  //           },
  //           onAdImpression: (RewardedAd ad) {
  //             //
  //           },
  //         );

  //         rewardedAd = ad;
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load a rewarded ad: ${err.message}');
  //       },
  //     ),
  //   );
  // }

  //TODO:Show rewarded ads
  // static void showRewardAd() {
  //   rewardedAd?.show(
  //     onUserEarnedReward: (_, rewardItem) {
  //       num ammount = rewardItem.amount;
  //       print("you earn $ammount point");
  //     },
  //   );
  // }

  //TODO:Chaeck time and show rewarded ads
  // static void tryToShowRewardAds() async {
  //   if (await AppUtils.currentTime() - await UserPrefs.getInt('last_ads_show') <
  //       await UserPrefs.getInt('ads_show_rate')) {
  //     print("Not yet");
  //   } else {
  //     print("Ok to show ads");
  //     showRewardAd();
  //     UserPrefs.setInt('last_ads_show', await AppUtils.currentTime());
  //   }
  // }

//////////////////////
////////////////////
///////////

  // TODO: Implement _loadRewardedInterstitialAd()
  static void loadRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdsHelper.rewardedInterstitialAdUnitId,
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedInterstitialAd ad) {
              //
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedInterstitialAd = null;
              loadRewardedInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              rewardedInterstitialAd = null;
              loadRewardedInterstitialAd();
            },
            onAdImpression: (RewardedInterstitialAd ad) {
              //
            },
          );

          rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewardedInterstitial ad: ${err.message}');
        },
      ),
    );
  }

  //TODO:Show rewarded interstitial
  static void showRewardedInterstitialAd() {
    print("hello");
    rewardedInterstitialAd?.show(
      onUserEarnedReward: (_, rewardItem) {
        num ammount = rewardItem.amount;
        print("you earn $ammount point");
      },
    );
  }

  //TODO:Check time and show rewarded interstitial
  // static void tryToShowRewardInterstitialAds() async {
  //   if (await AppUtils.currentTime() - await UserPrefs.getInt('last_ads_show') < await UserPrefs.getInt('ads_show_rate')) {
  //     print("Not yet");
  //   } else {
  //     print("Ok to show ads");
  //     showRewardedInterstitialAd();
  //     UserPrefs.setInt('last_ads_show', await AppUtils.currentTime());
  //   }
  // }
}
