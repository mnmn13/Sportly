//
//  WelcomeFlowStep3VM.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//

import UIKit

protocol InitialSetupFlowStep3VMType {
    
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

class InitialSetupFlowStep3VM: InitialSetupFlowStep3VMType {
    
    var reloadBarButton: SimpleClosure<SignUpReloadType>?
    var onReload: EmptyClosure?
    
    fileprivate let coordinator: InitialSetupFlowCoordinatorType
    private var masterService: MasterService
    private var callBackService: CallbackService
    private var items: [InitialSetupItems] = []
    
    private var teams: [TeamInfoResponse] = []
    private var selectedTeams: [TeamInfoResponse] = []
    
    
    init(coordinator: InitialSetupFlowCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.callBackService = serviceHolder.get()
        self.masterService = serviceHolder.get()
        getData()
    }

    func getData() {
        guard !masterService.teams.isEmpty else { guard !masterService.allTeams.isEmpty else { AlertHelper.showAlert(msg: "Internal error"); return };/* AlertHelper.showAlert(msg: "RequestError");*/ return }
        teams = masterService.teams
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        
        items = [
            .text(TextTVCellVM(text: "Select favourite teams", cellType: .title)),
            .bubbles(BubblesCellVM(callBackService: callBackService, bubbleType: .teams(teams), teamDataCallBack: { [weak self] team in
                guard let self = self else { return }
                self.selectedTeams.append(team)
                self.validate()
            }))
        ]
        onReload?()
    }
    
    private func validate() {
        if teams.isEmpty {
            reloadBarButton?(.disableButton)
        } else {
            reloadBarButton?(.enableButton)
        }
    }
    
    func nextTapped() {
        coordinator.completeInitialSetup()
    }
    
    func backTapped() {
        coordinator.getBackFromStep3()
    }
    
    //MARK: - TableView methods

    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> InitialSetupItems? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

