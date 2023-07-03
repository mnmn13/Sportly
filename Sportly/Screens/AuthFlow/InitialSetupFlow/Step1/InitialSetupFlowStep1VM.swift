//
//  InitialSetupFlowStep1VM.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//

import UIKit

protocol InitialSetupFlowStep1VMType {
    
    //Bind
    var reloadBarButton: SimpleClosure<SignUpReloadType>? { get set }
    
    //TableView
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> InitialSetupItems?
    
    func nextTapped()
}

class InitialSetupFlowStep1VM: InitialSetupFlowStep1VMType {
    
    var reloadBarButton: SimpleClosure<SignUpReloadType>?
    
    fileprivate let coordinator: InitialSetupFlowCoordinatorType
    private var masterService: MasterService
    private var callBackService: CallbackService
    private var items: [InitialSetupItems] = []
    private var gamesChosenModel: GamesChosenModel = GamesChosenModel()
    
    init(coordinator: InitialSetupFlowCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.callBackService = serviceHolder.get()
        self.masterService = serviceHolder.get()
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        
        items = [
            .text(TextTVCellVM(text: "Select favourite games", cellType: .title)),
//            .bubbles(BubblesCellVM(callBackService: callBackService, bubbleType: .text(getNames()))),
            .bubbles(BubblesCellVM(callBackService: callBackService, bubbleType: .gameLogo, logoDataCallBack: { [weak self] bubbleChosen in
                guard let self = self else { return }
                self.gamesChosenModel = bubbleChosen
                self.reloadButton()
            }))
        ]
    }
    
    private func reloadButton() {
        guard gamesChosenModel.isEmpty() else { reloadBarButton?(.disableButton); return }
        reloadBarButton?(.enableButton)
    }
    
    private func validate(bubbleChosen: GamesChosenModel) {
        
    }
    
    func nextTapped() {
        coordinator.goToStep2(gamesChosen: gamesChosenModel)
    }
    
    //MARK: - TableView methods

    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> InitialSetupItems? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

enum InitialSetupItems {
    case bubbles(BubblesCellVM)
    case text(TextTVCellVM)
    case spacing(CGFloat)
}
