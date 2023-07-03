//
//  SignUp2ViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol SignUp2ViewModelType {
    
    //Bind
    var reloadBarButton: SimpleClosure<SignUpReloadType>? { get set }
    var onReload: SimpleClosure<Changes>? { get set }
    
    //TableView
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> SignUpItem?
    
    //Actions
    func signUpTapped(view: UIView)
}

class SignUp2ViewModel: SignUp2ViewModelType {
    
    var reloadBarButton: SimpleClosure<SignUpReloadType>?
    var onReload: SimpleClosure<Changes>?
    
    fileprivate let coordinator: SignUp2CoordinatorType
    private let callBackService: CallbackService
    private let userService: UserService
    
    var items: [SignUpItem] = []
    var user: UserRegistration
    
    
//    let userName: String
//    let firstName: String
//    let lastName: String
    private var password: String?
    
    init(coordinator: SignUp2CoordinatorType, serviceHolder: ServiceHolder, user: UserRegistration) {
        self.coordinator = coordinator
        self.callBackService = serviceHolder.get()
        self.userService = serviceHolder.get()
        self.user = user
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        
        items = [
            .title(TextTVCellVM(text: "Secure account", cellType: .title)),
            .spacing(50),
            .email(PlaceholderTVCellVM(cellType: .email, dataCallBack: { [weak self] email in
                guard let self = self else { return }
                self.user.email = email
                    self.reloadButton()
            })),
            .spacing(20),
            .createPassword(PlaceholderTVCellVM(cellType: .createPassword, dataCallBack: { [weak self] password in
                guard let self = self else { return }
                self.callBackService.passwordCallBack?(password)

                    self.reloadButton()
            })),
            .spacing(20),
            .confirmPassword(PlaceholderTVCellVM(callBackService: callBackService, cellType: .confirmPassword, dataCallBack: { [weak self] password in
                guard let self = self else { return }
                self.user.password = password
                    self.reloadButton()
            }))
        ]
    }
    
    private func reloadButton() {
        guard let email = user.email, let password = user.password, !email.isEmpty, !password.isEmpty else { reloadBarButton?(.disableButton); return }
        reloadBarButton?(.enableButton)
    }
    
    func signUpTapped(view: UIView) {
        ProgressHudHelper.shared.showIndicator(view: view)
        userService.signUpWithEmail(user: user) { [weak self] result in
            switch result {
            case .failure(let error): ProgressHudHelper.shared.showError(view: view, details: error.localizedDescription)
            case .success(_):
                ProgressHudHelper.shared.showSuccess(view: view)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self?.coordinator.startPreFlow()
                }
            }
        }
    }
    
    func goBack() {
        
    }
    
    private func reloadScreen() {
        let old = items
        setupItems()
        onReload?(.init(new: items, old: old))
    }
    
    //MARK: - TableView
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> SignUpItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
    
}
