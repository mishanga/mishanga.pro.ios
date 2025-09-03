# iOS App Synchronization with Android

Это приложение iOS было синхронизировано с Android версией по логике и внешнему виду.

## Структура приложения

### Основные файлы
- `MainView.swift` - главный экран с навигацией (аналог MainActivity.kt)
- `ContentView.swift` - точка входа приложения
- `SampleMishangaApp.swift` - инициализация приложения и SDK

### Экраны рекламы (Ad/)
- `BannerAdView.swift` - экран баннерной рекламы (аналог BannerScreen.kt)
- `InterstitialAdView.swift` - экран межстраничной рекламы (аналог InterstitialScreen.kt)
- `RewardedAdView.swift` - экран видеорекламы с вознаграждением (аналог RewardedScreen.kt)

### Настройки и данные
- `SettingsView.swift` - экран настроек (аналог SettingsScreen.kt)
- `SettingsStore.swift` - хранение настроек (аналог SettingsStore.kt)
- `AdSettings.swift` - модель настроек рекламы (аналог AdSettings.kt)
- `AdConstants.swift` - константы для тестовых ID рекламных блоков (аналог AdConstants.kt)

### UI компоненты (UI/)
- `PrimaryButton.swift` - основная кнопка приложения (аналог PrimaryButton.kt)
- `CustomBackground.swift` - кастомный фон с градиентом (аналог CustomBackground.kt)
- `Colors.swift` - цветовая схема, идентичная Android версии

## Особенности реализации

### Цветовая схема
Использована идентичная Android версии цветовая палитра:
- Brand Primary: RGB(219, 254, 10) - яркий желто-зеленый
- Brand Black: RGB(0, 0, 0) - черный
- Gradient Background: Трехуровневый градиент в лавандовых тонах

### Навигация
- Используется SwiftUI NavigationView для навигации между экранами
- Кастомные заголовки с кнопками назад в стиле Android приложения
- Автоматическое скрытие navigation bar для полного контроля над UI

### Реклама
- Интеграция с YandexMobileAds SDK
- Поддержка всех типов рекламы: Banner, Interstitial, Rewarded
- Идентичная логика загрузки и показа рекламы
- Параметры запроса рекламы через настройки (uuid, region_id, aim_banner_id)

### Хранение данных
- UserDefaults для сохранения настроек (аналог SharedPreferences в Android)
- JSON сериализация для сложных объектов
- Singleton pattern для SettingsStore

## Соответствие Android версии

Приложение полностью соответствует Android версии по:
1. **Функциональности** - все экраны и их логика идентичны
2. **Внешнему виду** - цвета, компоненты, градиенты, шрифты
3. **Навигации** - структура переходов между экранами
4. **Настройкам** - идентичные поля и логика сохранения
5. **Рекламе** - аналогичная интеграция с YandexMobileAds

## Запуск приложения

1. Откройте `SampleMishanga.xcworkspace` в Xcode
2. Убедитесь, что все Pods установлены (`pod install`)
3. Выберите симулятор или устройство iOS
4. Запустите приложение

Приложение готово к тестированию и использованию.
