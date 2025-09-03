//
//  RewardedViewController.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import UIKit
import SwiftUI
import YandexMobileAds

class RewardedViewController: BaseAdController, RewardedAdLoaderDelegate {
    private lazy var rewardedAdLoader: RewardedAdLoader = {
        let loader = RewardedAdLoader()
        loader.delegate = self
        return loader
    }()

    private var rewardedAd: RewardedAd?
    var rewardCallback: ((Int) -> Void)?

    func loadAndShowAd(adUnitId: String, settings: AdSettings = AdSettings()) {
        let configuration = createAdRequestConfiguration(adUnitId: adUnitId, settings: settings)
        rewardedAdLoader.loadAd(with: configuration)
        showStatus("loading…")
    }

    func loadAd(adUnitId: String, settings: AdSettings = AdSettings()) {
        let configuration = createAdRequestConfiguration(adUnitId: adUnitId, settings: settings)
        rewardedAdLoader.loadAd(with: configuration)
        showStatus("loading…")
    }

    func showAd() {
        guard let rewardedAd = rewardedAd else {
            showError("ad not loaded")
            return
        }
        rewardedAd.show(from: self)
    }

    // MARK: - RewardedAdLoaderDelegate

    func rewardedAdLoader(_ adLoader: RewardedAdLoader, didLoad rewardedAd: RewardedAd) {
        self.rewardedAd = rewardedAd
        rewardedAd.delegate = self
        adDidLoad()

        // Automatically show the ad after loading
        DispatchQueue.main.async {
            if let rootViewController = self.getRootViewController() {
                rewardedAd.show(from: rootViewController)
            } else {
                self.showError("no root view controller found")
            }
        }
    }

    func rewardedAdLoader(_ adLoader: RewardedAdLoader, didFailToLoadWithError adRequestError: AdRequestError) {
        adDidFailToLoad(error: adRequestError.error.localizedDescription)
    }
}

extension RewardedViewController: RewardedAdDelegate {
    func rewardedAdDidShow(_ rewardedAd: RewardedAd) {
        adDidShow()
    }

    func rewardedAdDidDismiss(_ rewardedAd: RewardedAd) {
        adDidDismiss()
    }

    func rewardedAdDidClick(_ rewardedAd: RewardedAd) {
        adDidClick()
    }

    func rewardedAd(_ rewardedAd: RewardedAd, didTrackImpressionWith impressionData: ImpressionData?) {
        adDidTrackImpression()
    }

    func rewardedAdDidFailToShow(_ rewardedAd: RewardedAd, error: Error) {
        adDidFailToShow(error: error.localizedDescription)
    }

    func rewardedAd(_ rewardedAd: RewardedAd, didReward reward: Reward) {
        let amount = Int(reward.amount)
        rewardCallback?(amount)
        showSuccess("Rewarded ad completed! You earned \(amount) coins")
    }
}


