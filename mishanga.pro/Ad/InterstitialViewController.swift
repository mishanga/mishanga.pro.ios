//
//  InterstitialViewController.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import UIKit
import SwiftUI
import YandexMobileAds

class InterstitialViewController: BaseAdController, InterstitialAdLoaderDelegate {
    private lazy var interstitialAdLoader: InterstitialAdLoader = {
        let loader = InterstitialAdLoader()
        loader.delegate = self
        return loader
    }()

    private var interstitialAd: InterstitialAd?

    func loadAndShowAd(adUnitId: String, settings: AdSettings = AdSettings()) {
        let configuration = createAdRequestConfiguration(adUnitId: adUnitId, settings: settings)
        interstitialAdLoader.loadAd(with: configuration)
        showStatus("loading…")
    }

    func loadAd(adUnitId: String, settings: AdSettings = AdSettings()) {
        let configuration = createAdRequestConfiguration(adUnitId: adUnitId, settings: settings)
        interstitialAdLoader.loadAd(with: configuration)
        showStatus("loading…")
    }

    func showAd() {
        guard let interstitialAd = interstitialAd else {
            showError("ad not loaded")
            return
        }
        interstitialAd.show(from: self)
    }

    // MARK: - InterstitialAdLoaderDelegate

    func interstitialAdLoader(_ adLoader: InterstitialAdLoader, didLoad interstitialAd: InterstitialAd) {
        self.interstitialAd = interstitialAd
        interstitialAd.delegate = self
        adDidLoad()

        // Automatically show the ad after loading
        DispatchQueue.main.async {
            if let rootViewController = self.getRootViewController() {
                interstitialAd.show(from: rootViewController)
            } else {
                self.showError("no root view controller found")
            }
        }
    }

    func interstitialAdLoader(_ adLoader: InterstitialAdLoader, didFailToLoadWithError adRequestError: AdRequestError) {
        adDidFailToLoad(error: adRequestError.error.localizedDescription)
    }
}

extension InterstitialViewController: InterstitialAdDelegate {
    func interstitialAdDidShow(_ interstitialAd: InterstitialAd) {
        adDidShow()
    }

    func interstitialAdDidDismiss(_ interstitialAd: InterstitialAd) {
        adDidDismiss()
    }

    func interstitialAdDidClick(_ interstitialAd: InterstitialAd) {
        adDidClick()
    }

    func interstitialAd(_ interstitialAd: InterstitialAd, didTrackImpressionWith impressionData: ImpressionData?) {
        adDidTrackImpression()
    }

    func interstitialAdDidFailToShow(_ interstitialAd: InterstitialAd, error: Error) {
        adDidFailToShow(error: error.localizedDescription)
    }
}


