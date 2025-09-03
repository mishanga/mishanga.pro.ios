//
//  UniversalBannerView.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI
import YandexMobileAds

struct UniversalBannerView: View {
    let width: CGFloat
    let height: CGFloat
    let title: String
    
    @State private var status = "idle"
    @State private var reload = false
    @State private var settings = SettingsStore.shared.read()

    var body: some View {
        CustomBackground {
            VStack {
                VStack(spacing: 16) {
                    Spacer()

                    // Banner container
                    VStack {
                        BannerAdContainer(
                            width: width,
                            height: height,
                            adUnitId: getAdUnitId(),
                            reload: $reload,
                            status: $status,
                            settings: settings
                        )
                        .background(Color.backgroundSecondary)
                        .cornerRadius(8)
                    }

                    Spacer()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            settings = SettingsStore.shared.read()
            loadAd()
        }
    }

    private func getAdUnitId() -> String {
        if settings.adUnitId.isEmpty {
            return height == 250 ? AdConstants.testBanner300x250 : AdConstants.testBanner
        }
        return settings.adUnitId
    }

    private func loadAd() {
        status = "loading…"
        reload = true
    }
}

// MARK: - Banner Sizes
extension UniversalBannerView {
    static func banner300x250() -> UniversalBannerView {
        UniversalBannerView(width: 300, height: 250, title: "banner 300x250")
    }
    
    static func banner320x50() -> UniversalBannerView {
        UniversalBannerView(width: 320, height: 50, title: "banner 320x50")
    }
}

#Preview {
    UniversalBannerView.banner300x250()
}
