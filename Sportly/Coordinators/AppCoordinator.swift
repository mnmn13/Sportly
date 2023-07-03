//
//  AppCoordinator.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let serviceHolder = ServiceHolder()
    private var authFlowCoordinator: AuthFlowCoordinator?
    private var initialSetupFlowCoordinator: InitialSetupFlowCoordinator?
    private var mainFlowCoordinator: MainFlowCoordinator?
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        startServices()
//        startPreFlow()
//        startAuth()
        enterApp()
        UserDefaults.standard.isLoggedIn = false
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    private func start() {
        
    }
    
    private func startAuth() {
        authFlowCoordinator = AuthFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        authFlowCoordinator?.start()
    }
    
    func enterApp() {
        initialSetupFlowCoordinator = nil
        tabBarCoordinator = TabBarCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        tabBarCoordinator?.start()
    }
    
    private func start2() {
        mainFlowCoordinator = MainFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        mainFlowCoordinator?.start()
    }
    //MARK: - Preflow
    func startPreFlow() {
        authFlowCoordinator = nil
        initialSetupFlowCoordinator = InitialSetupFlowCoordinator(window: window, transitions: self, serviceHolder: serviceHolder)
        initialSetupFlowCoordinator?.start()
    }
}

//MARK: - Services routine
extension AppCoordinator {
    private func startServices() {
        serviceHolder.add(CallbackService.self, for: CallbackService())
        serviceHolder.add(UserService.self, for: UserService())
//        serviceHolder.add(ProgressHudService.self, for: ProgressHudService())
//        serviceHolder.add(ChatService.self, for: ChatService())
//        serviceHolder.add(OpenAIService.self, for: OpenAIService())
//        serviceHolder.add(StorageService.self, for: StorageService())
//        serviceHolder.add(MediaService.self, for: MediaService())
        serviceHolder.add(MasterService.self, for: MasterService())
    }
}
extension AppCoordinator: AuthFlowCoordinatorTransitions {
    func userDidLogin() {}
    
    func startWithoutLogin() {}
}
extension AppCoordinator: InitialSetupFlowCoordinatorTransitions {}
extension AppCoordinator: MainFlowCoordinatorTransitions {}
extension AppCoordinator: TabbarCoordinatorTransitions {}
