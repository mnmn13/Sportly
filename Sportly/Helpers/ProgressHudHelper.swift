//
//  ProgressHudHelper.swift
//  Sportly
//
//  Created by MN on 31.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProgressHudHelper {
    static let shared = ProgressHudHelper()
    private init() {}
    
    private let hud = JGProgressHUD()
    
    
    func showIndicator(view: UIView) {
        hud.show(in: view, animated: true)
    }
    
    func hideIndicator() {
        hud.dismiss(animated: true)
    }
    
    func showSuccess(view: UIView, delay: TimeInterval = 3) {
        hud.dismiss(animated: true)
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = "Success"
        hud.show(in: view, animated: true)
        hud.dismiss(afterDelay: delay, animated: true)
    }
    
    func showError(view: UIView, details: String?, delay: TimeInterval = 3) {
        hud.dismiss(animated: true)
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Error"
        hud.detailTextLabel.text = details
        hud.show(in: view, animated: true)
        hud.dismiss(afterDelay: delay, animated: true)
    }
    
    
    
}
