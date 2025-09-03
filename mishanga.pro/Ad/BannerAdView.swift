//
//  BannerAdView.swift
//  SampleMishanga
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import SwiftUI
import YandexMobileAds

struct BannerAdView: View {
    @State private var settings = SettingsStore.shared.read()
    @State private var centerBannerStatus = "idle"
    @State private var bottomBannerStatus = "idle"
    @State private var centerBannerReload = false
    @State private var bottomBannerReload = false

    var body: some View {
        CustomBackground {
            VStack {
                Spacer()
                
                // Center banner 300x250
                BannerAdContainer(
                    width: 300,
                    height: 250,
                    adUnitId: getCenterBannerAdUnitId(),
                    reload: $centerBannerReload,
                    status: $centerBannerStatus,
                    settings: settings
                )
                .background(Color.backgroundSecondary)
                .cornerRadius(8)
                .onAppear {
                    loadCenterBanner()
                }
                
                Spacer()
                
                // Bottom banner 320x50
                BannerAdContainer(
                    width: 320,
                    height: 50,
                    adUnitId: getBottomBannerAdUnitId(),
                    reload: $bottomBannerReload,
                    status: $bottomBannerStatus,
                    settings: settings
                )
                .background(Color.backgroundSecondary)
                .cornerRadius(8)
                .onAppear {
                    loadBottomBanner()
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("banner")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            settings = SettingsStore.shared.read()
        }
    }
    
    private func getCenterBannerAdUnitId() -> String {
        if settings.adUnitId.isEmpty {
            return AdConstants.testBanner300x250
        }
        return settings.adUnitId
    }
    
    private func getBottomBannerAdUnitId() -> String {
        if settings.adUnitId.isEmpty {
            return AdConstants.testBanner
        }
        return settings.adUnitId
    }
    
    private func loadCenterBanner() {
        centerBannerStatus = "loading…"
        centerBannerReload = true
    }
    
    private func loadBottomBanner() {
        bottomBannerStatus = "loading…"
        bottomBannerReload = true
    }
}

class BannerViewController: UIViewController, AdViewDelegate {
    private var adView: AdView?
    var statusCallback: ((String) -> Void)?

    func loadAd(adUnitId: String, width: CGFloat, height: CGFloat, settings: AdSettings = AdSettings()) {
        let adSize = BannerAdSize.fixedSize(withWidth: width, height: height)
        adView = AdView(adUnitID: adUnitId, adSize: adSize)
        adView?.delegate = self

        if let adView = adView {
            view.addSubview(adView)
            adView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                adView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                adView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                adView.widthAnchor.constraint(equalToConstant: width),
                adView.heightAnchor.constraint(equalToConstant: height)
            ])

            // Note: YandexMobileAds AdView doesn't support custom parameters directly
            // Custom parameters are typically handled at the ad request level

            statusCallback?("loading…")
            adView.loadAd()
        }
    }

    // MARK: - AdViewDelegate

    func adViewDidLoad(_ adView: AdView) {
        statusCallback?("loaded successfully")
    }

    func adViewDidFailLoading(_ adView: AdView, error: Error) {
        statusCallback?("error: \(error.localizedDescription)")
    }

    func adViewDidClick(_ adView: AdView) {
        statusCallback?("banner clicked")
    }

    func adView(_ adView: AdView, didTrackImpressionWith impressionData: ImpressionData?) {
        statusCallback?("banner impression tracked")
    }
}

struct BannerAdContainer: View {
    let width: CGFloat
    let height: CGFloat
    let adUnitId: String
    @Binding var reload: Bool
    @Binding var status: String
    let settings: AdSettings
    @State private var bannerViewController = BannerViewController()

    var body: some View {
        BannerControllerRepresentable(
            controller: bannerViewController,
            width: width,
            height: height,
            adUnitId: adUnitId,
            reload: $reload,
            status: $status
        )
        .frame(width: width, height: height)
        .onAppear {
            setupBannerController()
            if reload {
                loadAd()
            }
        }
        .onChange(of: reload) { newValue in
            if newValue {
                loadAd()
            }
        }
    }

    private func setupBannerController() {
        bannerViewController.statusCallback = { newStatus in
            DispatchQueue.main.async {
                self.status = newStatus
                if newStatus.contains("loaded") || newStatus.contains("error") {
                    self.reload = false
                }
            }
        }
    }

    private func loadAd() {
        bannerViewController.loadAd(adUnitId: adUnitId, width: width, height: height, settings: settings)
    }
}

struct BannerControllerRepresentable: UIViewControllerRepresentable {
    let controller: BannerViewController
    let width: CGFloat
    let height: CGFloat
    let adUnitId: String
    @Binding var reload: Bool
    @Binding var status: String

    func makeUIViewController(context: Context) -> BannerViewController {
        return controller
    }

    func updateUIViewController(_ uiViewController: BannerViewController, context: Context) {
        // Update if needed
    }
}

#Preview {
    BannerAdView()
}
