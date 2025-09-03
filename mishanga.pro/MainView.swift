//
//  MainView.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI
import YandexMobileAds

struct MainView: View {
    @State private var settings = SettingsStore.shared.read()
    @State private var interstitialViewController = InterstitialViewController()
    @State private var rewardedViewController = RewardedViewController()
    @StateObject private var toastManager = ToastManager()
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            CustomBackground {
                VStack {
                    // Navigation Bar
                    HStack {
                        Text("mishanga.pro")
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer()

                        NavigationLink(destination: SettingsView()) {
                            NavigationButton(systemName: "gearshape")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    // Main content
                    VStack(spacing: 16) {
                        Spacer().frame(height: 20)

                        VStack(spacing: 12) {
                            NavigationLink(destination: BannerAdView()) {
                                PrimaryButton(text: "banner")
                            }

                            PrimaryButton(text: "interstitial") {
                                showInterstitialAd()
                            }

                            PrimaryButton(text: "rewarded") {
                                showRewardedAd()
                            }
                        }
                        .padding(.horizontal, 32)

                        Spacer()

                        // Loading indicator
                        if isLoading {
                            VStack(spacing: 12) {
                                ProgressView()
                                    .scaleEffect(1.2)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .brandPrimary))

                                Text("Loading ad...")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                }
            }
            .toast(isShowing: $toastManager.isShowing, message: toastManager.message)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            settings = SettingsStore.shared.read()
            setupControllers()
        }
    }

    private func setupControllers() {
        // Setup interstitial controller
        interstitialViewController.statusCallback = { newStatus in
            DispatchQueue.main.async {
                if newStatus.contains("loading…") {
                    self.isLoading = true
                } else if newStatus.contains("loaded successfully") {
                    self.isLoading = false
                    self.toastManager.show("Interstitial ad loaded and showing! ✅")
                } else if newStatus.contains("error") {
                    self.isLoading = false
                    self.toastManager.show("Error: \(newStatus)")
                }
            }
        }

        // Setup rewarded controller
        rewardedViewController.statusCallback = { newStatus in
            DispatchQueue.main.async {
                if newStatus.contains("loading…") {
                    self.isLoading = true
                } else if newStatus.contains("loaded successfully") {
                    self.isLoading = false
                    self.toastManager.show("Rewarded ad loaded and showing! ✅")
                } else if newStatus.contains("error") {
                    self.isLoading = false
                    self.toastManager.show("Error: \(newStatus)")
                }
            }
        }
    }

    private func showInterstitialAd() {
        let adUnitId = settings.adUnitId.isEmpty ? AdConstants.testInterstitial : settings.adUnitId
        interstitialViewController.loadAndShowAd(adUnitId: adUnitId, settings: settings)
    }

    private func showRewardedAd() {
        let adUnitId = settings.adUnitId.isEmpty ? AdConstants.testRewarded : settings.adUnitId
        rewardedViewController.loadAndShowAd(adUnitId: adUnitId, settings: settings)
    }


}

#Preview {
    MainView()
}
