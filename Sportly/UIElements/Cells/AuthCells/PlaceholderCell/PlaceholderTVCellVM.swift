//
//  PlaceholderTVCellVM.swift
//  Sportly
//
//  Created by MN on 27.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct PlaceholderTVCellVM {

    var PVColor: SimpleClosure<PlaceHolderTVCellPVColor>?
    var test: SimpleClosure<String>?
    var callBackService: CallbackService?
    
    var cellType: PlaceholderTVCellStyleType
    var dataCallBack: SimpleClosure<String>?
    var user: UserRegistration?
    var password = "//&^#$%?#$%?^#$^?#$^?#^$#"
    var bufferValue = ""
    
    var trackTintColor = UIColor(projColors: .green1)
    var greenPVColor = UIColor(projColors: .green1)
    var normalPVColor = UIColor(projColors: .grayPV)
    var redPVColor = UIColor(projColors: .red)
    
    func validate(value: String) {
        switch cellType {
        case .userName:
            guard value.count >= 4 else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        case .firstName:
            guard value.count >= 2 else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        case .lastName:
            guard value.count >= 3 else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        case .email:
            guard value.isEmail() else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        case .createPassword:
            guard value.count >= 6 else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        case .confirmPassword:
            guard value == password else { PVColor?(.red); dataCallBack?(""); return }
            PVColor?(.green)
            dataCallBack?(value)
        }
    }
}

enum PlaceholderTVCellStyleType {
    case userName
    case firstName
    case lastName
    case email
    case createPassword
    case confirmPassword
    var placeHolder: String {
        switch self {
        case .userName: return "User name"
        case .firstName: return "First name"
        case .lastName: return "Last name"
        case .email: return "Email"
        case .createPassword: return "Create password"
        case .confirmPassword: return "Confirm password"
        }
    }
    
}

enum PlaceHolderTVCellPVColor {
    case grey
    case green
    case red
}
//MARK: - Extension Hashable
extension PlaceholderTVCellVM: Hashable {
    static func == (lhs: PlaceholderTVCellVM, rhs: PlaceholderTVCellVM) -> Bool {
        lhs.cellType == rhs.cellType &&
        lhs.user == rhs.user
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cellType)
        hasher.combine(user)
    }
}
