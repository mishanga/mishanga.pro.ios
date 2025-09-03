//
//  BaseAdController.swift
//  mishanga.pro
//
//  Created by Matvei Nazaruk on 01.09.2025.
//

import UIKit
import YandexMobileAds

protocol AdControllerDelegate: AnyObject {
    func adDidLoad()
    func adDidFailToLoad(error: String)
    func adDidShow()
    func adDidDismiss()
    func adDidClick()
    func adDidTrackImpression()
    func adDidFailToShow(error: String)
}

class BaseAdController: UIViewController {
    weak var delegate: AdControllerDelegate?
    var statusCallback: ((String) -> Void)?
    
    // MARK: - Common Methods
    
    func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        return window.rootViewController
    }
    
    func showStatus(_ message: String) {
        statusCallback?(message)
    }
    
    func showError(_ error: String) {
        statusCallback?("error: \(error)")
    }
    
    func showSuccess(_ message: String) {
        statusCallback?(message)
    }
    
    // MARK: - Ad Configuration Helper
    
        func createAdRequestConfiguration(adUnitId: String, settings: AdSettings) -> AdRequestConfiguration {
        let requestConfiguration = MutableAdRequestConfiguration(adUnitID: adUnitId)
        
        // Add custom parameters from settings
        var parameters = Dictionary<String, String>()
        
        if !settings.aimBannerId.isEmpty {
            parameters["ai_banner_id"] = settings.aimBannerId
        }
        
        if !settings.uuid.isEmpty {
            parameters["uuid"] = settings.uuid
        }
        
        if !settings.regionId.isEmpty {
            parameters["region_id"] = settings.regionId
        }
        
        // Set parameters if any exist
        if !parameters.isEmpty {
            requestConfiguration.parameters = parameters
        }
        
        return requestConfiguration
    }
}

// MARK: - AdControllerDelegate Default Implementation
extension BaseAdController {
    func adDidLoad() {
        showSuccess("loaded successfully")
    }

    func adDidFailToLoad(error: String) {
        showError(error)
    }

    func adDidShow() {
        showSuccess("ad shown successfully")
    }

    func adDidDismiss() {
        showSuccess("ad dismissed")
    }

    func adDidClick() {
        showSuccess("ad clicked")
    }

    func adDidTrackImpression() {
        showSuccess("ad impression tracked")
    }

    func adDidFailToShow(error: String) {
        showError("failed to show - \(error)")
    }
}
