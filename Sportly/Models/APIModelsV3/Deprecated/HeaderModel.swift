//
//  HeaderModel.swift
//  Sportly
//
//  Created by MN on 14.05.2023.
//

import Foundation

struct Header: HashCoded {
    
    var apiKey: String = "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4"
    var apiHost: String = "api-football-v1.p.rapidapi.com"
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "X-RapidAPI-Key"
        case apiHost = "X-RapidAPI-Host"
    }
}
