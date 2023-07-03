//
//  InitialSetupFlowCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//


import UIKit

protocol InitialSetupFlowCoordinatorTransitions: AnyObject {
    func enterApp()
}

protocol InitialSetupFlowCoordinatorType {
    func goToStep2(gamesChosen: GamesChosenModel)
    func getBackFromStep2()
    func goToStep3()
    func getBackFromStep3()
    func completeInitialSetup()
}

class InitialSetupFlowCoordinator: InitialSetupFlowCoordinatorType {
    
    let serviceHolder: ServiceHolder
    private let window: UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private weak var transitions: InitialSetupFlowCoordinatorTransitions?
    private var step1Controller: InitialSetupFlowStep1VC?
    private var step2Controller: InitialSetupFlowStep2VC?
    private var step3Controller: InitialSetupFlowStep3VC?
    
    init(window: UIWindow, transitions: InitialSetupFlowCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        step1Controller = InitialSetupFlowStep1VC()
        if let step1Controller = step1Controller {
            step1Controller.viewModel = InitialSetupFlowStep1VM(coordinator: self, serviceHolder: serviceHolder)
            rootNav.setViewControllers([step1Controller], animated: true)
            window.rootViewController = rootNav
            window.makeKeyAndVisible()
        }
    }
    
    func goToStep2(gamesChosen: GamesChosenModel) {
        
        step2Controller = InitialSetupFlowStep2VC()
        
        if let step2Controller = step2Controller {
            step2Controller.viewModel = InitialSetupFlowStep2VM(coordinator: self, serviceHolder: serviceHolder, gamesChosenModel: gamesChosen)
            
            step1Controller?.view.alpha = 1.0
            step2Controller.view.alpha = 0.0
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let self = self else { return }
                self.step1Controller?.view.alpha = 0.0
            }) { [weak self] _ in
                guard let self = self else { return }
                rootNav.pushViewController(step2Controller, animated: false)
                UIView.animate(withDuration: 0.5) {
                    step2Controller.view.alpha = 1.0
                }
            }
        }
    }
    
    func getBackFromStep2() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.step2Controller?.view.alpha = 0.0
        }) { [weak self] _ in
            guard let self = self else { return }
            rootNav.popViewController(animated: false)
            UIView.animate(withDuration: 0.5) {
                self.step1Controller?.view.alpha = 1.0
            }
        }
    }
    
    func goToStep3() {
        step3Controller = InitialSetupFlowStep3VC()
        
        if let step3Controller = step3Controller {
            step3Controller.viewModel = InitialSetupFlowStep3VM(coordinator: self, serviceHolder: serviceHolder)
            
            step2Controller?.view.alpha = 1.0
            step3Controller.view.alpha = 0.0
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let self = self else { return }
                self.step2Controller?.view.alpha = 0.0
            }) { [weak self] _ in
                guard let self = self else { return }
                rootNav.pushViewController(step3Controller, animated: false)
                UIView.animate(withDuration: 0.5) {
                    step3Controller.view.alpha = 1.0
                }
            }
        }
    }
    
    func getBackFromStep3() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.step3Controller?.view.alpha = 0.0
        }) { [weak self] _ in
            guard let self = self else { return }
            rootNav.popViewController(animated: false)
            UIView.animate(withDuration: 0.5) {
                self.step2Controller?.view.alpha = 1.0
            }
        }
    }
    
    func completeInitialSetup() {
        transitions?.enterApp()
    }
}
