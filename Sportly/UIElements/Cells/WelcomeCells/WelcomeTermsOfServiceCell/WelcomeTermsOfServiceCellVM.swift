//
//  WelcomeTermsOfServiceCellVM.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct WelcomeTermsOfServiceCellVM {
    var text = "By continuing, you agree to Sportly's Terms of Service and Privacy Policy"
    
    var termsOfServiceCallBack: SimpleClosure<TermsType>?
    
}

enum TermsType {
    case termsOfService
    case privacyPolicy
}
