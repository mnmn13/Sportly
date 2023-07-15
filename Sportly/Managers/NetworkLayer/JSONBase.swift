//
//  JSONBase.swift
//  Sportly
//
//  Created by MN on 09.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class JSONBase {
    
    func getDataFromJSON(_ file: JSONFiles) -> Data? {
        if let fileURL = Bundle.main.url(forResource: file.fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                return data
            } catch {
                let error = ErrorGenesis.testingError(.jsonFileError)
                BannerManager.shared.show(.warning, error.localizedDescription)
                print("Failed to load data from JSON file: \(error.localizedDescription)")
                return nil
            }
        } else {
            let error = ErrorGenesis.testingError(.jsonFileNotFound)
            BannerManager.shared.show(.error, error.localizedDescription)
            print("JSON file not found: \(file.fileName).json")
            return nil
        }
    }
}

enum JSONFiles {
    case standingsV3
    case fixturesV3
    case fixturesV2
    case playerStatsV3All
    case playerStatsV3
    
    var folderPath: String { "Resources/JSON/" }
    
    var fileName: String {
        switch self {
        case .standingsV3: return "standingsV3"
        case .fixturesV3: return "fixturesV3"
        case .fixturesV2: return "fixturesV2"
        case .playerStatsV3All: return "playerStatsV3allPages"
        case .playerStatsV3: return "playerStatsV3"
        }
    }
}
