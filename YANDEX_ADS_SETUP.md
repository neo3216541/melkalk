# Настройка Яндекс Рекламы

## Что было сделано

1. **Установлен плагин** `yandex_mobileads` версии 7.18.0
2. **Настроен Android**:
   - Добавлено разрешение `INTERNET` в AndroidManifest.xml
   - minSdkVersion уже установлен на 21 (требуется минимум 21)

3. **Настроен iOS**:
   - Добавлены SKAdNetworkItems в Info.plist для поддержки атрибуции
   - Минимальная версия iOS 12.0 (уже настроена в проекте)

4. **Инициализация SDK**:
   - Добавлен вызов `MobileAds.initialize()` в `main.dart`

5. **Создан виджет баннерной рекламы**:
   - `lib/features/mel_calculator/presentation/widgets/yandex_banner_ad.dart`
   - Использует sticky banner (закрепленный внизу экрана)
   - Автоматически подстраивается под ширину экрана

6. **Интегрирован баннер на главный экран**:
   - Баннер отображается внизу экрана в MainScreen

## Что нужно сделать дальше

### 1. Зарегистрируйте приложение в Яндекс Рекламной сети

1. Войдите в [Рекламную сеть Яндекса](https://partner.yandex.ru/)
2. Зарегистрируйте ваше приложение
3. Создайте рекламные блоки (Ad Units) для разных форматов

### 2. Замените тестовый Block ID на реальный

В файле `lib/features/mel_calculator/presentation/widgets/yandex_banner_ad.dart`:

```dart
// Замените эту строку:
const adUnitId = 'demo-banner-yandex';

// На ваш реальный Block ID из Яндекс Рекламной сети:
const adUnitId = 'R-M-XXXXXX-X'; // Ваш Block ID
```

### 3. Доступные форматы рекламы

#### Sticky Banner (уже реализован)
- Небольшой баннер внизу или вверху экрана
- Автоматически обновляется
- Не перекрывает контент

#### Inline Banner
```dart
BannerAd(
  adUnitId: 'your-inline-block-id',
  adSize: BannerAdSize.inlineSize(
    width: MediaQuery.of(context).size.width.toInt(),
    maxHeight: 400,
  ),
  adRequest: const AdRequest(),
  // ...
);
```

#### Межстраничная реклама (Interstitial)
```dart
InterstitialAd? _interstitialAd;

void _loadInterstitialAd() {
  _interstitialAd = InterstitialAd(
    adUnitId: 'your-interstitial-block-id',
    adRequest: const AdRequest(),
    onAdLoaded: () {
      _interstitialAd?.show();
    },
    onAdFailedToLoad: (error) {
      debugPrint('Interstitial failed: ${error.description}');
    },
  );
  _interstitialAd?.load();
}
```

#### Реклама с вознаграждением (Rewarded)
```dart
RewardedAd? _rewardedAd;

void _loadRewardedAd() {
  _rewardedAd = RewardedAd(
    adUnitId: 'your-rewarded-block-id',
    adRequest: const AdRequest(),
    onAdLoaded: () {
      _rewardedAd?.show();
    },
    onRewarded: (Reward reward) {
      // Выдайте награду пользователю
      debugPrint('User earned reward: ${reward.amount} ${reward.type}');
    },
  );
  _rewardedAd?.load();
}
```

### 4. Тестирование

Для тестирования используйте тестовые Block ID:
- Banner: `demo-banner-yandex`
- Interstitial: `demo-interstitial-yandex`
- Rewarded: `demo-rewarded-yandex`

### 5. Политика конфиденциальности

Если требуется настроить политику использования персональных данных, добавьте перед инициализацией SDK:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Настройка политики конфиденциальности (опционально)
  MobileAds.setUserConsent(true); // или false
  
  MobileAds.initialize();
  
  await di.init();
  runApp(const MyApp());
}
```

### 6. Проверка интеграции

После запуска приложения проверьте логи:
- **iOS**: В Xcode Console установите фильтр `Subsystem = com.mobile.ads.ads.sdk`
- **Android**: В Logcat ищите сообщения от Yandex Mobile Ads SDK

## Полезные ссылки

- [Документация Яндекс Рекламы для Flutter](https://ads.yandex.com/helpcenter/ru/dev/flutter/quick-start)
- [GitHub репозиторий плагина](https://github.com/yandexmobile/yandex-ads-flutter-plugin)
- [Личный кабинет Рекламной сети Яндекса](https://partner.yandex.ru/)

## Примечания

- Реклама будет показываться только после одобрения приложения в Яндекс Рекламной сети
- Для iOS требуется добавить описание использования данных в App Store Connect
- Рекомендуется не показывать рекламу слишком часто, чтобы не ухудшить пользовательский опыт
