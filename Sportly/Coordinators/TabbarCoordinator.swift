//
//  TabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import UIKit

enum TabBarItems: Int {
    case home
    case discover
    case predict
    case stats
    case profile
    
    case settings
}

protocol TabbarCoordinatorTransitions: AnyObject {
//    func logout()
}

protocol TabbarItemsCoordinatorType: AnyObject {
    var rootController: UINavigationController { get }
    var tabBarItem: UITabBarItem { get }
}

class TabBarCoordinator {

    private weak var window: UIWindow?
    private weak var transitions: TabbarCoordinatorTransitions?
    private let serviceHolder: ServiceHolder

    private let tabBarController = UITabBarController()
    private var tabCoordinators: [TabbarItemsCoordinatorType] = []

    init(window: UIWindow, transitions: TabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder

        tabBarController.tabBar.barTintColor = RGBColor(240, 240, 240)
        tabBarController.tabBar.tintColor = RGBColor(20, 20, 20)

        //tab bar items coordinator init
        let firstTabCoordinator = HomeTabbarCoordinator(transitions: self, serviceHolder: serviceHolder)
        firstTabCoordinator.start()

        let secondTabCoordinator = DiscoverTabbarCoordinator(transitions: self, serviceHolder: serviceHolder)
        secondTabCoordinator.start()

        let thirdTabCoordinator = PredictTabbarCoordinator(transitions: self, serviceHolder: serviceHolder)
        thirdTabCoordinator.start()
        
        let fourthTabCoordinator = StatsTabbarCoordinator(transitions: self, serviceHolder: serviceHolder)
        fourthTabCoordinator.start()
        
        let fifthTabCoordinator = ProfileTabbarCoordinator(transitions: self, serviceHolder: serviceHolder)
        fifthTabCoordinator.start()

        tabCoordinators = [firstTabCoordinator, secondTabCoordinator, thirdTabCoordinator, fourthTabCoordinator, fifthTabCoordinator]
        tabBarController.viewControllers = [firstTabCoordinator.rootController, secondTabCoordinator.rootController, thirdTabCoordinator.rootController, fourthTabCoordinator.rootController, fifthTabCoordinator.rootController]
    }

    func start(animated: Bool = false) {
        guard let window = window else { return }

        if (animated) { // from login
            UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { [weak self] in
                window.rootViewController = self?.tabBarController
            }, completion: nil)
        } else {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
}

//MARK: TabBarCoordinator {
extension TabBarCoordinator {

    func getTabCoordinator<T>(index: Int) -> T? {
        if index < tabCoordinators.count {
            return tabCoordinators[index] as? T
        }
        return nil
    }

    func selectTab(index: TabBarItems) {
        let tabIndex = index.rawValue
        tabBarController.selectedIndex = tabIndex
        let root = getTabCoordinatorRootNavigation(index: index)
        root?.popViewController(animated: false)
    }

    private func getTabCoordinatorRootNavigation(index: TabBarItems) -> UINavigationController? {
        let tabIndex = index.rawValue
        if tabIndex < tabCoordinators.count {
            let tabItem = tabCoordinators[tabIndex]
            return tabItem.rootController
        }
        return nil
    }
}

extension TabBarCoordinator: HomeTabbarCoordinatorTransitions {}
extension TabBarCoordinator: DiscoverTabbarCoordinatorTransitions {}
extension TabBarCoordinator: PredictTabbarCoordinatorTransitions {}
extension TabBarCoordinator: StatsTabbarCoordinatorTransitions {}
extension TabBarCoordinator: ProfileTabbarCoordinatorTransitions {}
