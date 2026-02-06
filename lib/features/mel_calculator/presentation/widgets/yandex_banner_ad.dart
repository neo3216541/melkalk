import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class YandexBannerAd extends StatefulWidget {
  const YandexBannerAd({super.key});

  @override
  State<YandexBannerAd> createState() => _YandexBannerAdState();
}

class _YandexBannerAdState extends State<YandexBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdCreated = false;
  bool _isAdLoaded = false;
  double? _actualHeight;

  @override
  void initState() {
    super.initState();
    debugPrint('🔵 YandexBannerAd: initState called');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint(
        '🔵 YandexBannerAd: didChangeDependencies called, _isAdCreated=$_isAdCreated');

    if (!_isAdCreated) {
      debugPrint('🔵 YandexBannerAd: Creating banner ad...');
      _createBannerAd();
      _isAdCreated = true;
    } else {
      debugPrint('🔵 YandexBannerAd: Banner already created, skipping');
    }
  }

  BannerAdSize _getAdSize() {
    final screenWidth = MediaQuery.of(context).size.width.round();
    debugPrint('🔵 YandexBannerAd: Screen width = $screenWidth');
    final adSize = BannerAdSize.sticky(width: screenWidth);
    debugPrint(
        '🔵 YandexBannerAd: Created BannerAdSize.sticky with width=$screenWidth');
    return adSize;
  }

  void _createBannerAd() {
    // Block ID из Яндекс Рекламной сети
    const adUnitId = 'R-M-2196377-1';

    debugPrint('🟢 YandexBannerAd: Starting banner creation');
    debugPrint('🟢 YandexBannerAd: Ad Unit ID = $adUnitId');

    try {
      final adSize = _getAdSize();
      debugPrint('🟢 YandexBannerAd: Got ad size, creating BannerAd object...');

      _bannerAd = BannerAd(
        adUnitId: adUnitId,
        adSize: adSize,
        adRequest: const AdRequest(),
        onAdLoaded: () async {
          debugPrint('✅✅✅ Banner ad LOADED successfully! ✅✅✅');

          // Получаем реальные размеры баннера после загрузки
          try {
            final calculatedSize =
                await _bannerAd?.adSize.getCalculatedBannerAdSize();
            debugPrint(
                '✅ Initial size: ${_bannerAd?.adSize.width} x ${_bannerAd?.adSize.height}');
            debugPrint(
                '✅ Calculated size: ${calculatedSize?.width} x ${calculatedSize?.height}');

            if (mounted) {
              debugPrint('✅ Widget is mounted, calling setState');
              setState(() {
                _isAdLoaded = true;
                _actualHeight = calculatedSize?.height.toDouble() ?? 50.0;
              });
              debugPrint(
                  '✅ setState completed, _isAdLoaded=$_isAdLoaded, _actualHeight=$_actualHeight');
            } else {
              debugPrint('⚠️ Widget is NOT mounted, cannot call setState');
            }
          } catch (e) {
            debugPrint('⚠️ Error getting calculated size: $e');
            if (mounted) {
              setState(() {
                _isAdLoaded = true;
                _actualHeight = 50.0;
              });
            }
          }
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌❌❌ Banner ad FAILED to load! ❌❌❌');
          debugPrint('❌ Error description: ${error.description}');
          debugPrint('❌ Error code: ${error.code}');
        },
        onAdClicked: () {
          debugPrint('👆👆👆 Banner ad CLICKED! 👆👆👆');
        },
        onImpression: (impressionData) {
          debugPrint('👁️👁️👁️ Banner ad IMPRESSION recorded! 👁️👁️👁️');
        },
        onLeftApplication: () {
          debugPrint('🚪 User LEFT application from ad');
        },
        onReturnedToApplication: () {
          debugPrint('🔙 User RETURNED to application');
        },
      );

      debugPrint('🟢 YandexBannerAd: BannerAd object created successfully');
      debugPrint('🟢 YandexBannerAd: _bannerAd is null? ${_bannerAd == null}');
    } catch (e, stackTrace) {
      debugPrint('💥💥💥 EXCEPTION while creating banner ad! 💥💥💥');
      debugPrint('💥 Exception: $e');
      debugPrint('💥 StackTrace: $stackTrace');
    }
  }

  @override
  void dispose() {
    debugPrint('🔴 YandexBannerAd: dispose called');
    _bannerAd?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🔵 YandexBannerAd: build called');
    debugPrint('🔵 _bannerAd is null? ${_bannerAd == null}');
    debugPrint('🔵 _isAdLoaded? $_isAdLoaded');
    debugPrint('🔵 _actualHeight? $_actualHeight');

    if (_bannerAd == null) {
      debugPrint('⚠️ YandexBannerAd: Banner is NULL, showing placeholder');
      return Container(
        height: 50,
        color: Colors.red[100],
        child: const Center(
          child: Text('Banner is NULL', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    final adWidth = _bannerAd!.adSize.width.toDouble();
    // Используем реальную высоту если она есть, иначе 50
    final adHeight = _actualHeight ?? 50.0;

    debugPrint(
        '🟢 YandexBannerAd: Building AdWidget with size ${adWidth}w x ${adHeight}h');
    debugPrint('🟢 YandexBannerAd: Ad loaded status: $_isAdLoaded');

    return Container(
      width: adWidth,
      height: adHeight,
      color: _isAdLoaded ? null : Colors.yellow[100],
      child: Stack(
        children: [
          AdWidget(bannerAd: _bannerAd!),
          if (!_isAdLoaded)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
