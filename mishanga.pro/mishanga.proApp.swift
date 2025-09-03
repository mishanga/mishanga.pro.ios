//
//  mishanga.proApp.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI
import YandexMobileAds

@main
struct mishanga_proApp: App {
    init() {
        // Инициализация Yandex MobileAds SDK
        MobileAds.initializeSDK()

        // Настройка логирования (опционально, для отладки)
        #if DEBUG
        MobileAds.enableLogging()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
