//
//  SimpleTFCellVM.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class SimpleTFCellVM {
    
    // MARK: - CellCallback
    var progressStateCallBack: SimpleClosure<SimpleTFCellValidationState>?
    
    let callBackService: CallbackService
    let cellType: SimpleTFCellVMType
    var dataCallBack: SimpleClosure<String>?
    var validationPassed: Bool? = nil
    var password = "//&^#$%?#$%?^#$^?#$^?#^$#"
    
    init(callBackService: CallbackService, cellType: SimpleTFCellVMType) {
        self.callBackService = callBackService
        self.cellType = cellType
        bindForPassword()
    }
    
    private func bindForPassword() {
        if cellType == .passwordConfirm {
            callBackService.passwordCallBack = { [weak self] password in
                guard let self else { return }
                self.password = password
            }
        }
    }
    
    func validate(_ value: String ) {
        switch cellType {
        case .userName:
            guard value.count >= 4 else { progressStateCallBack?(.unverified); dataCallBack?(""); return }
            progressStateCallBack?(.confirmed)
            dataCallBack?(value)
        case .firstName:
            guard value.count >= 2 else { progressStateCallBack?(.unverified); dataCallBack?(""); return }
            progressStateCallBack?(.unverified)
            dataCallBack?(value)
        case .lastName:
            guard value.count >= 3 else { progressStateCallBack?(.unverified); dataCallBack?(""); return }
            progressStateCallBack?(.unverified)
            dataCallBack?(value)
        case .email: break
            guard value.isEmail() else { validationPassed = false; dataCallBack?(""); return }
            validationPassed = true
//            dataCallBack?(text)
        case .passwordCreate: break
            guard value.count >= 6 else { progressStateCallBack?(.undefined); dataCallBack?(""); return }
//            PVColor?(.green)
//            dataCallBack?(text)
        case .passwordConfirm: break
            guard value == password else { progressStateCallBack?(.undefined); dataCallBack?(""); return }
//            PVColor?(.green)
//            dataCallBack?(text)
        }
    }
    
    
}

extension SimpleTFCellVM: Hashable {
    static func == (lhs: SimpleTFCellVM, rhs: SimpleTFCellVM) -> Bool {
        return lhs.cellType == rhs.cellType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cellType)
    }
}

enum SimpleTFCellVMType: Hashable {
    case email
    case passwordCreate
    case passwordConfirm
    case userName
    case firstName
    case lastName
    
    var labelName: String {
        switch self {
        case .email: return "Email"
        case .passwordCreate: return "Create password"
        case .passwordConfirm: return "Confirm password"
        case .userName: return "User name"
        case .firstName: return "First name"
        case .lastName: return "LastName"
        }
    }
}

enum SimpleTFCellValidationState {
    case undefined
    case confirmed
    case unverified
}
