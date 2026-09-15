import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  ///is use for takeing full width of device and devicePixelRatio take ratio for calculations
  /// PlatformDispatcher.instance.views.first.physicalSize.width
  /// PlatformDispatcher.instance.views.first.devicePixelRatio

  BannerAd? bannerAd;
  List<BannerAd> bannerAds = [];

  ///Create/load/show Banner Ad
  void createBannerAd() {
    if (bannerAd != null) {
      bannerAd!.dispose();
    }
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: showBannerAd(),
      request: const AdRequest(),
    )..load();
    print(bannerAd);
  }

  int attemptOfBnanners = 0;

  /// Banner ad show Controll
  BannerAdListener showBannerAd() {
    return BannerAdListener(
      onAdLoaded: (ad) {
        print("Ad Loaded:${ad.adUnitId}.");
      },
      onAdFailedToLoad: (ad, error) {
        print("Ad failed to load:${ad.adUnitId}.$error");
        if (attemptOfBnanners <= 3) {
          createBannerAd();
          attemptOfBnanners++;
        } else {
          ad.dispose();
        }
      },
    );
  }

  NativeAd? nativeAd;
  final bool _nativeAdIsLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  /// Loads a native ad.
  NativeAd createNativeAd() {
    try {
      // nativeAd =
      return NativeAd(
        nativeAdOptions:
            NativeAdOptions(mediaAspectRatio: MediaAspectRatio.unknown),
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdClicked: (ad) {
            print(ad);
          },
          onAdOpened: (ad) {
            print(ad);
          },
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$nativeAd failed to load: $error');
            // ad.dispose();
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small),
        // Styling
      );
      // return nativeAd!;
    } catch (e) {
      log('', name: 'native ad error', error: e.toString());
      rethrow;
    }
  }
}
