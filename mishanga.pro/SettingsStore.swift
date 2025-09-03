//
//  SettingsStore.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import Foundation

class SettingsStore: ObservableObject {
    static let shared = SettingsStore()

    private let userDefaults = UserDefaults.standard
    private let settingsKey = "yango_ads_settings"

    private init() {}

    func read() -> AdSettings {
        guard let data = userDefaults.data(forKey: settingsKey),
              let settings = try? JSONDecoder().decode(AdSettings.self, from: data) else {
            return AdSettings()
        }
        return settings
    }

    func write(_ settings: AdSettings) {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        userDefaults.set(data, forKey: settingsKey)
    }

    func clear() {
        userDefaults.removeObject(forKey: settingsKey)
    }
}
