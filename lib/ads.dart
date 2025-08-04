import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdHelper {
  // Test ad unit IDs - replace with your actual ad unit IDs
  static const String _bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  
  static BannerAd? _bannerAd;
  static bool _isBannerAdReady = false;

  // Initialize Mobile Ads SDK
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // Create and load banner ad
  static void createBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _isBannerAdReady = true;
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd!.load();
  }

  // Get banner ad widget
  static Widget getBannerAdWidget() {
    if (_bannerAd != null && _isBannerAdReady) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return Container(
        width: 320,
        height: 50,
        color: Colors.grey[300],
        child: const Center(
          child: Text('Ad Loading...'),
        ),
      );
    }
  }

  // Check if banner ad is ready
  static bool get isBannerAdReady => _isBannerAdReady;

  // Dispose banner ad
  static void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerAdReady = false;
  }
}