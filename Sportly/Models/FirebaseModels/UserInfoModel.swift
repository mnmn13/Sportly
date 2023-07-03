//
//  UserInfoModel.swift
//  Sportly
//
//  Created by MN on 29.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct UserInfo: HashCoded {
    var userName: String
    var firstName: String
    var lastName: String
    var email: String
    var uid: String = UUID().uuidString
}
