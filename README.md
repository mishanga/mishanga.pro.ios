# SampleMishanga iOS - Yandex MobileAds SDK

Этот проект демонстрирует интеграцию Yandex MobileAds SDK в iOS приложение, созданное с помощью SwiftUI.

## Что добавлено

### 1. Зависимости
- **Yandex MobileAds SDK** - добавлен через Swift Package Manager
- Версия: 6.0.0+

### 2. Конфигурация
- `Info.plist` с необходимыми разрешениями для рекламы
- SKAdNetwork идентификаторы для различных рекламных сетей
- Разрешение на отслеживание пользователя (NSUserTrackingUsageDescription)

### 3. Инициализация SDK
- Автоматическая инициализация при запуске приложения
- Настройка логирования для отладки

### 4. Примеры рекламы

#### Баннерная реклама
- Автоматически отображается в главном экране
- Использует тестовый ID блока `demo-banner-yandex`

#### Межстраничная реклама
- Полноэкранная реклама между экранами
- Пример загрузки и показа

#### Видеореклама с вознаграждением
- Реклама с наградой за просмотр
- Система накопления монет

## Настройка для продакшена

### 1. Замените тестовые ID блоков
В файлах `ContentView.swift` и `AdExamples.swift` замените:
- `demo-banner-yandex` → ваш реальный ID баннерного блока
- `demo-interstitial-yandex` → ваш реальный ID межстраничного блока  
- `demo-rewarded-yandex` → ваш реальный ID блока с вознаграждением

### 2. Настройте таргетинг
```swift
let request = YMAAdRequestConfiguration(adUnitID: "your-ad-unit-id")
request.parameters = [
    "age": "25",
    "gender": "male"
]
```

### 3. Добавьте аналитику
```swift
// Отслеживание событий
YMAAdEventLogger.logEvent(.adShown, adUnitID: "your-ad-unit-id")
```

## Структура проекта

```
SampleMishanga/
├── SampleMishangaApp.swift      # Главный файл приложения + инициализация SDK
├── ContentView.swift            # Главный экран + баннерная реклама
├── AdExamples.swift             # Примеры различных типов рекламы
├── Info.plist                   # Конфигурация с разрешениями
└── Assets.xcassets/             # Ресурсы приложения
```

## Требования

- iOS 12.0+
- Xcode 14.0+
- Swift 5.0+

## Полезные ссылки

- [Документация Yandex MobileAds](https://yandex.ru/dev/mobile-ads/)
- [GitHub репозиторий SDK](https://github.com/yandexmobile/yandex-mobile-ads-ios)
- [Руководство по интеграции](https://yandex.ru/dev/mobile-ads/doc/ios/quick-start.html)

## Отладка

Для включения подробного логирования добавьте в `SampleMishangaApp.swift`:
```swift
#if DEBUG
YMAMobileAds.setLogLevel(.debug)
#endif
```

## Тестирование

Все примеры используют тестовые ID блоков, которые всегда возвращают тестовую рекламу. Это позволяет безопасно тестировать интеграцию без риска показа реальной рекламы пользователям.

## Поддержка

При возникновении проблем:
1. Проверьте логи в консоли Xcode
2. Убедитесь, что все разрешения добавлены в Info.plist
3. Проверьте подключение к интернету
4. Обратитесь к документации Yandex MobileAds

