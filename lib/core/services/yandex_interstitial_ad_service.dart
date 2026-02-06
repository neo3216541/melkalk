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

  // Счётчик сохранений
  int _saveCounter = 0;
  static const int _savesBeforeAd = 5; // Показывать рекламу каждые 5 сохранений

  // Block ID для межстраничной рекламы из Яндекс Рекламной сети
  // Временно используем тестовый ID, замените на реальный после создания блока
  static const String _adUnitId =
      'R-M-2196377-2'; // TODO: Заменить на R-M-2196377-X

  /// Увеличивает счётчик сохранений и показывает рекламу если нужно
  /// Возвращает true если реклама была показана
  Future<bool> onSaveAction() async {
    _saveCounter++;
    debugPrint('💾 Save counter: $_saveCounter/$_savesBeforeAd');

    if (_saveCounter >= _savesBeforeAd) {
      debugPrint('🎯 Reached $_savesBeforeAd saves, showing ad...');
      _saveCounter = 0; // Сбрасываем счётчик
      return await showAd();
    }

    debugPrint(
        '⏭️ Skipping ad, need ${_savesBeforeAd - _saveCounter} more saves');
    return false;
  }

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
      // Загружаем рекламу для следующего раза
      loadAd();
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

  /// Возвращает текущий счётчик сохранений
  int get saveCounter => _saveCounter;

  /// Освобождает ресурсы
  void dispose() {
    debugPrint('🔴 Interstitial: Disposing ad');
    _interstitialAd?.destroy();
    _interstitialAd = null;
    _adLoader = null;
    _isAdLoading = false;
    _saveCounter = 0;
  }
}
