//
//  CellForTableViewCellVM.swift
//  Sportly
//
//  Created by MN on 14.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import SnapKit

struct CellForTableViewCellVM {
    
    fileprivate let callBackService: CallbackService
    
    let logo: String
    let leagueTitle: String
    
    init(callBackService: CallbackService, logo: String, leagueTitle: String) {
        self.callBackService = callBackService
        self.logo = logo
        self.leagueTitle = leagueTitle
    }
}

extension CellForTableViewCellVM: Equatable {
    static func ==(lhs: CellForTableViewCellVM, rhs: CellForTableViewCellVM) -> Bool {
        return lhs.callBackService === rhs.callBackService && lhs.logo == rhs.logo && lhs.leagueTitle == rhs.leagueTitle
    }
}
