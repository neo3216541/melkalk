import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

/// Сервис для управления межстраничной рекламой Яндекс
class YandexInterstitialAdService {
  static final YandexInterstitialAdService _instance =
      YandexInterstitialAdService._internal();
  factory YandexInterstitialAdService() => _instance;
  YandexInterstitialAdService._internal();

  InterstitialAd? _interstitialAd;
  InterstitialAdLoader? _adLoader;
  bool _isAdLoading = false;

  // Block ID для межстраничной рекламы из Яндекс Рекламной сети
  static const String _adUnitId = 'R-M-2196377-2';

  /// Загружает межстраничную рекламу
  Future<void> loadAd() async {
    if (_isAdLoading) {
      debugPrint('🟡 Interstitial: Already loading, skipping');
      return;
    }

    if (_interstitialAd != null) {
      debugPrint('🟡 Interstitial: Ad already loaded, skipping');
      return;
    }

    _isAdLoading = true;
    debugPrint('🟢 Interstitial: Starting to load ad with ID: $_adUnitId');

    try {
      _adLoader = await InterstitialAdLoader.create(
        onAdLoaded: (InterstitialAd interstitialAd) {
          debugPrint('✅ Interstitial: Ad loaded successfully!');
          _interstitialAd = interstitialAd;
          _isAdLoading = false;

          // Устанавливаем слушатели событий
          _interstitialAd?.setAdEventListener(
            eventListener: InterstitialAdEventListener(
              onAdShown: () {
                debugPrint('👁️ Interstitial: Ad shown');
              },
              onAdFailedToShow: (error) {
                debugPrint('❌ Interstitial: Failed to show ad');
                debugPrint('❌ Error: ${error.description}');
                _interstitialAd = null;
              },
              onAdDismissed: () {
                debugPrint('🚪 Interstitial: Ad dismissed');
                _interstitialAd = null;
                // Предзагружаем следующую рекламу
                loadAd();
              },
              onAdClicked: () {
                debugPrint('👆 Interstitial: Ad clicked');
              },
              onAdImpression: (impressionData) {
                debugPrint('📊 Interstitial: Impression recorded');
              },
            ),
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ Interstitial: Failed to load ad');
          debugPrint('❌ Error: ${error.description}');
          debugPrint('❌ Code: ${error.code}');
          _isAdLoading = false;
          _interstitialAd = null;
        },
      );

      final adRequestConfiguration =
          AdRequestConfiguration(adUnitId: _adUnitId);
      await _adLoader?.loadAd(adRequestConfiguration: adRequestConfiguration);
      debugPrint('🟢 Interstitial: Load request sent');
    } catch (e, stackTrace) {
      debugPrint('💥 Interstitial: Exception while loading ad');
      debugPrint('💥 Exception: $e');
      debugPrint('💥 StackTrace: $stackTrace');
      _isAdLoading = false;
      _interstitialAd = null;
    }
  }

  /// Показывает межстраничную рекламу, если она загружена
  Future<bool> showAd() async {
    if (_interstitialAd == null) {
      debugPrint('⚠️ Interstitial: Ad not loaded, cannot show');
      return false;
    }

    try {
      debugPrint('🟢 Interstitial: Showing ad...');
      await _interstitialAd?.show();
      await _interstitialAd?.waitForDismiss();
      return true;
    } catch (e) {
      debugPrint('💥 Interstitial: Exception while showing ad: $e');
      return false;
    }
  }

  /// Проверяет, загружена ли реклама
  bool get isAdLoaded => _interstitialAd != null;

  /// Освобождает ресурсы
  void dispose() {
    debugPrint('🔴 Interstitial: Disposing ad');
    _interstitialAd?.destroy();
    _interstitialAd = null;
    _adLoader = null;
    _isAdLoading = false;
  }
}
