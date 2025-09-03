# 📦 Swift Package Manager зависимости

## Текущие зависимости

### 1. Yandex MobileAds SDK
- **Имя пакета**: `yandex-mobile-ads-ios`
- **URL репозитория**: https://github.com/yandexmobile/yandex-mobile-ads-ios
- **Версия**: 7.15.0+
- **Тип версии**: upToNextMinorVersion
- **Продукт**: YandexMobileAds

## 📍 Расположение в проекте

### В файле `project.pbxproj`:

#### packageReferences (строка 103)
```objc
packageReferences = (
    D2E48A462E65A0B000881103 /* XCRemoteSwiftPackageReference "yandex-mobile-ads-ios" */,
);
```

#### XCRemoteSwiftPackageReference (строки 352-361)
```objc
D2E48A462E65A0B000881103 /* XCRemoteSwiftPackageReference "yandex-mobile-ads-ios" */ = {
    isa = XCRemoteSwiftPackageReference;
    repositoryURL = "https://github.com/yandexmobile/yandex-mobile-ads-ios";
    requirement = {
        kind = upToNextMinorVersion;
        minimumVersion = 7.15.0;
    };
};
```

#### XCSwiftPackageProductDependency (строки 365-369)
```objc
D2E48A472E65A0B000881103 /* YandexMobileAds */ = {
    isa = XCSwiftPackageProductDependency;
    package = D2E48A462E65A0B000881103 /* XCRemoteSwiftPackageReference "yandex-mobile-ads-ios" */;
    productName = YandexMobileAds;
};
```

## 🔍 Как найти зависимости

### 1. В Xcode (рекомендуется)
- Откройте проект
- Выберите проект в навигаторе
- Вкладка "Package Dependencies"

### 2. В файле project.pbxproj
```bash
# Все SPM пакеты
grep -A 5 "XCRemoteSwiftPackageReference" SampleMishanga.xcodeproj/project.pbxproj

# Конкретный пакет
grep -A 10 "yandex-mobile-ads-ios" SampleMishanga.xcodeproj/project.pbxproj

# Продукты пакетов
grep -A 3 "XCSwiftPackageProductDependency" SampleMishanga.xcodeproj/project.pbxproj
```

### 3. Через скрипт
```bash
./show_spm_dependencies.sh
```

## ➕ Как добавить новую зависимость

### В Xcode:
1. **File** → **Add Package Dependencies**
2. Введите URL репозитория
3. Выберите версию
4. Выберите продукты для добавления

### Вручную (не рекомендуется):
1. Добавить в `packageReferences`
2. Создать `XCRemoteSwiftPackageReference`
3. Создать `XCSwiftPackageProductDependency`
4. Добавить в `packageProductDependencies` таргета

## 📋 Типы версий

- **upToNextMajorVersion**: 7.15.0 ≤ версия < 8.0.0
- **upToNextMinorVersion**: 7.15.0 ≤ версия < 7.16.0
- **exactVersion**: точно 7.15.0
- **branch**: конкретная ветка
- **revision**: конкретный коммит

## 🚨 Важные замечания

- **Не редактируйте project.pbxproj вручную** - используйте Xcode
- **Всегда проверяйте совместимость** версий
- **Делайте резервные копии** перед изменениями
- **Используйте семантическое версионирование**

## 🔧 Полезные команды

```bash
# Проверка зависимостей
./check_dependencies.sh

# Просмотр SPM зависимостей
./show_spm_dependencies.sh

# Поиск конкретной зависимости
grep -r "YandexMobileAds" .
```

