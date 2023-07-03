//
//  BubbleModel.swift
//  Sportly
//
//  Created by MN on 01.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct BubbleModel {
    var text: String
    var image: UIImage
}

enum BubbleModelType {
    case images
    case imagesWithText
    case text
}

public struct BubbleLogoModel {
    var text: String?
    var image: UIImage?
    var id: Int?
        
   public func getArray() -> [Self] {
        let allTypes: [BubbleLogoModelType] = [.footBall, .basketball, .baseball, .volleyball, .NBA, .rugby, .hockey]
        
        let array = allTypes.map { type in
            switch type {
            case .footBall:
                let model = BubbleLogoModel(text: "Football", image: UIImage(named: "footballLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .basketball:
                let model = BubbleLogoModel(text: "Basketball", image: UIImage(named: "basketLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .baseball:
                let model = BubbleLogoModel(text: "Baseball", image: UIImage(named: "baseballLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .volleyball:
                let model = BubbleLogoModel(text: "Volleyball", image: UIImage(named: "volleyballLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .NBA:
                let model = BubbleLogoModel(text: "NBA", image: UIImage(named: "nbaLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .rugby:
                let model = BubbleLogoModel(text: "Rugby", image: UIImage(named: "rugbyLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            case .hockey:
                let model = BubbleLogoModel(text: "Hockey", image: UIImage(named: "hockeyLogo") ?? UIImage(systemName: "questionmark.circle")!)
                return model
            }
        }
       return array
    }
    
    public func getLeagues() {
        
    }
    
    enum BubbleLogoModelType {
        case footBall
        case basketball
        case baseball
        case volleyball
        case NBA
        case rugby
        case hockey
    }
    
}

struct BubbleOtherLogos {
    
    var image: UIImage?
    var id: Int?
    
    
//    func setupForLeague(leagues: [LeaguesInfoResponse]) -> [Self] {
        
//        leagues.map {  }
        
        
        
//    }
    
    
}
