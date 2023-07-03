//
//  WelcomeViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol WelcomeViewModelType {
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> WelcomeItem?
}

class WelcomeViewModel: WelcomeViewModelType {
    
    fileprivate let coordinator: WelcomeCoordinatorType
    var items: [WelcomeItem] = []
    
    init(coordinator: WelcomeCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        
        items = [
            .spacing(30),
            .logo(WelcomeLogoCellVM()),
            .spacing(20),
            .welcomeTitle(WelcomeTitleCellVM()),
            .spacing(80),
            .signUpEmail(WelcomeSignUpEmailCellVM(actionClosure: { [weak self] in self?.coordinator.openEmailSignUp() })),
            .or(WelcomeOfCellVM()),
            .signInApple(WelcomeSignInAppleVM(actionClosure: { [weak self] in self?.appleCurrentlyUnavailable(string: "Sign in woth Apple currently unavailable") })),
            .spacing(10),
            .withoutRegistration(WelcomeWithoutRegCellVM()),
            .spacing(50),
            .logIn(WelcomeLoginCellVM(actionClosure: { [weak self] in self?.appleCurrentlyUnavailable(string: "Not yet") })),
            .spacing(50),
            .termsOfService(WelcomeTermsOfServiceCellVM(termsOfServiceCallBack: { [weak self] type in
                switch type {
                case .privacyPolicy: self?.coordinator.openTerms(type: .privacyPolicy)
                case .termsOfService: self?.coordinator.openTerms(type: .termsAndConditions)
                }
            }))
        ]
    }
    
    private func appleCurrentlyUnavailable(string: String) {
        AlertHelper.showAlert(msg: string)
    }
    
    func getItemsCount() -> Int { items.count }
    func getItem(indexPath: IndexPath) -> WelcomeItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

    enum WelcomeItem {
        //Images
        case logo(WelcomeLogoCellVM)
        //Buttons
        case signUpEmail(WelcomeSignUpEmailCellVM)
        case signInApple(WelcomeSignInAppleVM)
        case withoutRegistration(WelcomeWithoutRegCellVM)
        //Labels
        case welcomeTitle(WelcomeTitleCellVM)
        case or(WelcomeOfCellVM)
        case logIn(WelcomeLoginCellVM)
        case termsOfService(WelcomeTermsOfServiceCellVM)
        
        case spacing(CGFloat)
    }
