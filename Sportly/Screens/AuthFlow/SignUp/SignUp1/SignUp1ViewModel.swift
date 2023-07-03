//
//  SignUp1ViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol SignUp1ViewModelType {
    
    //Bind
    var reloadBarButton: SimpleClosure<SignUpReloadType>? { get set }
    
    //TableView
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> SignUpItem?
    
    //Action
    func goNext()
    func goBack()
    
    func reloadButton()
}

class SignUp1ViewModel: SignUp1ViewModelType {
    
    var reloadBarButton: SimpleClosure<SignUpReloadType>?
    
    fileprivate let coordinator: SignUp1CoordinatorType
    var items: [SignUpItem] = []
    var user = UserRegistration()
    
    private var userName = ""
    private var fName = ""
    private var lName = ""
    
    init(coordinator: SignUp1CoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        
        items = [
            .title(TextTVCellVM(text: "Create account", cellType: .title)),
            .spacing(50),
            .userName(PlaceholderTVCellVM(cellType: .userName, dataCallBack: { [weak self] userName in
                guard let self = self else { return }
                self.userName = userName
                self.user.userName = userName
                self.reloadButton()
            }, user: user)),
            .spacing(20),
            .firstName(PlaceholderTVCellVM(cellType: .firstName, dataCallBack: { [weak self] firstName in
                guard let self = self else { return }
                self.fName = firstName
                self.user.firstName = firstName
                self.reloadButton()
            })),
            .spacing(20),
            .lastName(PlaceholderTVCellVM(cellType: .lastName, dataCallBack: { [weak self] lastName in
                guard let self = self else { return }
                self.lName = lastName
                self.user.lastName = lastName
                self.reloadButton()
            }))
        ]
        
        
    }
    
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> SignUpItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
    
    func goNext() {
        coordinator.goToSignUp2(user: user)    }
    
    func goBack() {
        coordinator.backClicked()
    }
    
    func reloadButton() {
        guard !userName.isEmpty, !fName.isEmpty, !lName.isEmpty else { reloadBarButton?(.disableButton); return }
        reloadBarButton?(.enableButton)
    }
    
}

enum SignUpItem: Hashable {
    case userName(PlaceholderTVCellVM)
    case firstName(PlaceholderTVCellVM)
    case lastName(PlaceholderTVCellVM)
    case email(PlaceholderTVCellVM)
    case createPassword(PlaceholderTVCellVM)
    case confirmPassword(PlaceholderTVCellVM)
    case title(TextTVCellVM)
    case text(TextTVCellVM)
    case spacing(CGFloat)
}

enum SignUpReloadType {
    case enableButton
    case disableButton
}
