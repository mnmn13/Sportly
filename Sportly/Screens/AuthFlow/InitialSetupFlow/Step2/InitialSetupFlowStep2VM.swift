//
//  WelcomeFlowStep2VM.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//

import UIKit

protocol InitialSetupFlowStep2VMType {
    
    //Bind
    var reloadBarButton: SimpleClosure<SignUpReloadType>? { get set }
    var onReload: EmptyClosure? { get set }
    
    //TableView
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> InitialSetupItems?
    
    //Actions
    func nextTapped()
    func backTapped()
}

class InitialSetupFlowStep2VM: InitialSetupFlowStep2VMType {
    
    var reloadBarButton: SimpleClosure<SignUpReloadType>?
    var onReload: EmptyClosure?
    
    fileprivate let coordinator: InitialSetupFlowCoordinatorType
    private var masterService: MasterService
    private var callBackService: CallbackService
    private var items: [InitialSetupItems] = []
    
    private var gamesChosenModel: GamesChosenModel
    private var leagueData: [LeaguesInfoResponse] = []
    private var leaguesChosen: [LeaguesInfoResponse] = []
    
    init(coordinator: InitialSetupFlowCoordinatorType, serviceHolder: ServiceHolder, gamesChosenModel: GamesChosenModel) {
        self.coordinator = coordinator
        self.callBackService = serviceHolder.get()
        self.masterService = serviceHolder.get()
        self.gamesChosenModel = gamesChosenModel
        getData()
    }
    
    func getData() {
        guard let leagues = masterService.leagues else { AlertHelper.showAlert(msg: "RequestError"); return }
        leagueData = leagues
        setupItems()
    }
        
        private func setupItems() {
            items.removeAll()
            
            items = [
                .text(TextTVCellVM(text: "Select favourite leagues", cellType: .title)),
                .bubbles(BubblesCellVM(callBackService: callBackService, bubbleType: .leagues(leagueData), leagueDataCallBack: { [weak self] league in
                    guard let self = self else { return }
                    self.leaguesChosen.append(league)
                    self.validate()
                    requestForTeams(league: league)
                    
                    print(league)
                }))
            ]
            onReload?()
        }
        
        private func validate() {
            if leaguesChosen.isEmpty {
                reloadBarButton?(.disableButton)
            } else {
                reloadBarButton?(.enableButton)
            }
        }
        
        private func requestForTeams(league: LeaguesInfoResponse) {
            guard let season = league.seasons!.filter( { $0.current == true } ).first else { return }
            masterService.requestForTeamsByLeague(league: league.league.id, season: season.year)
        }
        
        func nextTapped() {
        if leaguesChosen.isEmpty {
            coordinator.completeInitialSetup()
        } else {
            coordinator.goToStep3()
            }
        }
    
        func backTapped() {
            coordinator.getBackFromStep2()
        }
        
        //MARK: - TableView methods
        
        func getItemsCount() -> Int { items.count }
        
        func getItem(indexPath: IndexPath) -> InitialSetupItems? {
            guard items.indices.contains(indexPath.item) else { return nil }
            return items[indexPath.item]
        }
    }
