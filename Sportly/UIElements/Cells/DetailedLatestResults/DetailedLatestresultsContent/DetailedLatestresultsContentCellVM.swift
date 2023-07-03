//
//  DetailedLatestresultsContentCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedLatestresultsContentCellVM {
    let teamLogo: String?
    let teamName: String?
    let teamScore: Int?
    let isTeamLead: Bool
}

extension DetailedLatestresultsContentCellVM: Hashable {}
