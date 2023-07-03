//
//  LogoAndTitleTVCellVM.swift
//  Sportly
//
//  Created by MN on 19.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LogoAndTitleTVCellVM {
    
    let logo: String
    let leagueTitle: String
    
    init(logo: String, leagueTitle: String) {
        self.logo = logo
        self.leagueTitle = leagueTitle
    }
}

extension LogoAndTitleTVCellVM: Hashable {}
