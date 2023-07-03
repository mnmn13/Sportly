//
//  BubblesCellVM.swift
//  Sportly
//
//  Created by MN on 01.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import SpriteKit

struct BubblesCellVM {
    
    let callBackService: CallbackService
    var bubbleType: BubbleType
    var logoDataCallBack: SimpleClosure<GamesChosenModel>?
    var leagueDataCallBack: SimpleClosure<LeaguesInfoResponse>?
    var teamDataCallBack: SimpleClosure<TeamInfoResponse>?
    
    var bubbleLeagues: [LeagueBubbleModel] = []
    var bubbleTeams: [TeamsBubbleModel] = []
    
    let logos: [UIImage] = [
        UIImage(named: "footballLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "basketLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "baseballLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "volleyballLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "nbaLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "rugbyLogo") ?? UIImage(systemName: "questionmark.circle")!,
        UIImage(named: "hockeyLogo") ?? UIImage(systemName: "questionmark.circle")!
    ]
    
    var selectedNodes: [Node] = []
    
    mutating func addBubbles(magnetic: Magnetic?) {
        
        switch bubbleType {
        case .logo(let array):
            for image in array {
                let radius: CGFloat = CGFloat.random(in: 20...40)
                let node = Node(image: image, color: .clear, radius: radius)
                node.strokeColor = UIColor(projColors: .gray)
                magnetic?.addChild(node)
            }
            
        case .text(let array):
            for text in array {
                let radius: CGFloat = CGFloat.random(in: 40...100)
                let node = Node(text: text, color: .clear, radius: radius)
                node.strokeColor = UIColor(projColors: .gray)
                node.label.fontColor = .black
                node.lineWidth = 10
                magnetic?.addChild(node)
            }
            
        case .gameLogo:
            let bubbleLogos = BubbleLogoModel().getArray()
            let _ = bubbleLogos.map {
                let radius: CGFloat = CGFloat.random(in: 50...100)
                let node = Node(image: $0.image, color: .white, radius: radius)
                node.strokeColor = UIColor(projColors: .gray)
                node.text = $0.text
                node.label.fontColor = .black
                magnetic?.addChild(node)
            }
            
        case .otherLogos: break
            
        case .leagues(let leaguesModel): convertAndAddBubbles(magnetic: magnetic, leaguesModel: leaguesModel)
        case .teams(let teams): convertAndAddTeams(magnetic: magnetic, teamsModel: teams)
        }
    }
    
    //MARK: - Game logos
    func validate(nodes: [Node]) {
        switch bubbleType {
        case .logo: break
        case .text: break
        case .gameLogo:
            let gamesChosen = validateLogo(nodes: nodes)
            logoDataCallBack?(gamesChosen)
        case .otherLogos:
            break
        case .leagues:
            break
        case .teams(_): break
        }
    }
    
    func validateLogo(nodes: [Node]) -> GamesChosenModel {
        
        var gamesChosenModel = GamesChosenModel()
        
        for node in nodes {
            if let image = node.image {
                switch image {
                case UIImage(named: "baseballLogo"): gamesChosenModel.baseball = true
                case UIImage(named: "basketLogo"): gamesChosenModel.basketball = true
                case UIImage(named: "footballLogo"): gamesChosenModel.footBall = true
                case UIImage(named: "hockeyLogo"): gamesChosenModel.hockey = true
                case UIImage(named: "nbaLogo"): gamesChosenModel.NBA = true
                case UIImage(named: "rugbyLogo"): gamesChosenModel.rugby = true
                case UIImage(named: "volleyballLogo"): gamesChosenModel.volleyball = true
                default: print("Undetected choise")
                }
            }
        }
        return gamesChosenModel
    }
    
    //MARK: - Leagues
    mutating private func convertAndAddBubbles(magnetic: Magnetic?, leaguesModel: [LeaguesInfoResponse]) {
        
        self.bubbleLeagues = leaguesModel.map { LeagueBubbleModel(value: $0) }.filter { $0.value.league.id >= 1 && $0.value.league.id <= 120 }
        for index in 0...12 {
            
            let model = bubbleLeagues[index].value
            
            UIImage.loadImage(with: model.league.logo) { image in
                let radius: CGFloat = CGFloat.random(in: 35...65)
                let node = Node(text: model.league.name, image: image, color: .white, radius: radius)
                node.strokeColor = UIColor(projColors: .gray)
                node.text = model.league.name
                node.name = model.league.name
                node.label.fontColor = .black
                magnetic?.addChild(node)
            }
            bubbleLeagues[index].isOnScreen = true
        }
    }
    
    mutating func validateLeagues(node: SKNode, magnetic: Magnetic?) {
        if let text = node.name {
            if let index = bubbleLeagues.firstIndex(where: { $0.key == text }) {
                let returnModel = bubbleLeagues[index].value
                leagueDataCallBack?(returnModel)
                bubbleLeagues.remove(at: index)
                addNewLeagueBubbles(magnetic: magnetic)
            }
        }
    }
    
    mutating private func addNewLeagueBubbles(magnetic: Magnetic?) {
        let bubbleModel = bubbleLeagues.filter ({ $0.isOnScreen == false })
        guard let model = bubbleModel.first?.value else { return }
        guard let index = bubbleLeagues.firstIndex(where: { $0.key == model.league.name } ) else { return }
        bubbleLeagues[index].isOnScreen = true
        UIImage.loadImage(with: model.league.logo) { image in
            let radius: CGFloat = CGFloat.random(in: 35...65)
            let node = Node(text: model.league.name, image: image, color: .white, radius: radius)
            node.strokeColor = UIColor(projColors: .gray)
            node.text = model.league.name
            node.name = model.league.name
            node.label.fontColor = .black
            magnetic?.addChild(node)
        }
    }
    
    //MARK: - Teams
    mutating private func convertAndAddTeams(magnetic: Magnetic?, teamsModel: [TeamInfoResponse]) {
        bubbleTeams = teamsModel.map { TeamsBubbleModel(value: $0) }
        
        for index in 0...12 {
            let model = bubbleTeams[index]
            UIImage.loadImage(with: model.value.team.logo) { image in
                let radius: CGFloat = CGFloat.random(in: 35...65)
                let node = Node(text: model.value.team.name, image: image, color: .white, radius: radius)
                node.strokeColor = UIColor(projColors: .gray)
                node.text = model.value.team.name
                node.name = model.value.team.name
                node.label.fontColor = .black
                magnetic?.addChild(node)
            }
            bubbleTeams[index].isVisible = true
        }
    }
    
    mutating func validateTeams(node: SKNode, magnetic: Magnetic?) {
        if let text = node.name {
            if let index = bubbleTeams.firstIndex(where: { $0.key == text } ) {
                let returnModel = bubbleTeams[index].value
                teamDataCallBack?(returnModel)
                bubbleTeams.remove(at: index)
                addNewTeamBubble(magnetic: magnetic)
            }
        }
    }
    
    mutating private func addNewTeamBubble(magnetic: Magnetic?) {
        let teamModel = bubbleTeams.filter { $0.isVisible == false }
        guard let model = teamModel.first?.value else { return }
        guard let index = bubbleTeams.firstIndex(where: { $0.key == model.team.name } ) else { return }
        bubbleTeams[index].isVisible = true
        UIImage.loadImage(with: model.team.logo) { image in
            let radius: CGFloat = CGFloat.random(in: 35...65)
            let node = Node(text: model.team.name, image: image, color: .white, radius: radius)
            node.strokeColor = UIColor(projColors: .gray)
            node.text = model.team.name
            node.name = model.team.name
            node.label.fontColor = .black
            magnetic?.addChild(node)
        }
    }
    
    mutating func eraseNodes() {
        selectedNodes.removeAll()
        validate(nodes: selectedNodes)
    }
}

enum BubbleType {
    case logo([UIImage])
    case gameLogo
    case text([String])
    case otherLogos
    case leagues([LeaguesInfoResponse])
    case teams([TeamInfoResponse])
    //    case data
}

enum BubbleChosen {
    case footBall
    case basketball
    case baseball
    case volleyball
    case NBA
    case rugby
    case hockey
    
    var logo: UIImage {
        switch self {
        case .footBall: return UIImage(named: "footballLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .basketball: return UIImage(named: "basketLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .baseball: return UIImage(named: "baseballLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .volleyball: return UIImage(named: "volleyballLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .NBA: return UIImage(named: "nbaLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .rugby: return UIImage(named: "rugbyLogo") ?? UIImage(systemName: "questionmark.circle")!
        case .hockey: return UIImage(named: "hockeyLogo") ?? UIImage(systemName: "questionmark.circle")!
        }
    }
}

enum OtherLogosBubbleType {
    case leagues
    case teams
}
