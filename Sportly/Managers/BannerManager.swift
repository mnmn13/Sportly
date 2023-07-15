//
//  BannerManager.swift
//  Sportly
//
//  Created by MN on 11.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class BannerManager {
    
    static let shared = BannerManager()
    
    private init() {}
    private var keyWindow: UIWindow = {
        guard let window = UIApplication.shared.keyWindow else { fatalError() }
        return window
    }()
    
    private var bannerView: BannerView?
    private var initialPanPosition: CGPoint = .zero
    
    func show(_ state: BannerViewState ,_ message: String) {
        
        bannerView = BannerView()
        guard let bannerView = bannerView else { return }
        bannerView.configure(BannerViewVM(state: state, message: message))
        
        keyWindow.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(keyWindow.snp.top).offset(40)
            make.leading.equalTo(keyWindow.snp.leading).offset(20)
            make.trailing.equalTo(keyWindow.snp.trailing).offset(-20)
        }
        
        bannerView.frame.origin.y -= bannerView.frame.height
        
        UIView.animate(withDuration: 0.3) {
//            bannerView.frame.origin.y += bannerView.frame.height
            bannerView.frame.origin.y = 0
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        bannerView.addGestureRecognizer(panGesture)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration: 0.3) {
                bannerView.frame.origin.y -= bannerView.frame.height
            } completion: { _ in
                bannerView.removeFromSuperview()
            }
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let bannerView = bannerView else { return }
        let translation = gesture.translation(in: bannerView)
        
        switch gesture.state {
            
        case .possible:
            break
        case .began:
            initialPanPosition = bannerView.frame.origin
        case .changed:
            let newY = initialPanPosition.y + translation.y
            bannerView.frame.origin.y = newY
        case .ended, .cancelled, .failed:
            let velocity = gesture.velocity(in: bannerView)
            let shouldDismiss = abs(velocity.y) > 500 || bannerView.frame.origin.y < -keyWindow.bounds.height / 2
            
            if shouldDismiss {
                hideBanner()
            } else {
                resetBannerPosition()
            }
        @unknown default:
            break
        }
    }
    
    private func hideBanner() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.bannerView?.frame.origin.y = -self.keyWindow.bounds.height
        } completion: { [weak self] _ in
            guard let self else { return }
            self.bannerView?.removeFromSuperview()
            self.bannerView = nil
        }
    }
    
    private func resetBannerPosition() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.bannerView?.frame.origin = self.initialPanPosition
        }
    }
}
