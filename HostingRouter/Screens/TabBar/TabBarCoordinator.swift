//
//  TabBarCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import SwiftUI
import Combine

final class TabBarCoordinator: CoordinatorProtocol {
    
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    
    private let tabBarController = UITabBarController()
    private let profileNavigationController = UINavigationController()
    
    private let badgeCount = CurrentValueSubject<Int, Never>(0)
    private let selectedTab = PassthroughSubject<Int, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(toRootSwitcher: PassthroughSubject<Flow, Never>) {
        
        self.toRootSwitcher = toRootSwitcher
        
        bind()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension TabBarCoordinator {
    
    func bind() {
        
        badgeCount
            .sink { [weak self] in
                self?.profileNavigationController.tabBarItem.badgeValue = String($0)
            }
            .store(in: &cancellable)
        
        selectedTab
            .sink { [weak self] in
                self?.tabBarController.selectedIndex = $0
            }
            .store(in: &cancellable)
    }
}

extension TabBarCoordinator {
    
    func start() -> UITabBarController {
        
        let mainNavigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController,
                                              badgeCount: badgeCount,
                                              selectedTab: selectedTab)
        
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController,
                                                    toRootSwitcher: toRootSwitcher)
        
        mainNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Main", comment: ""),
                                                           image: UIImage(systemName: "house"),
                                                           tag: 0)
        profileNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Profile", comment: ""),
                                                              image: UIImage(systemName: "person"),
                                                              tag: 1)
        
        childCoordinators = [mainCoordinator, profileCoordinator]
        
        let controllers = [mainNavigationController, profileNavigationController]
        tabBarController.viewControllers = controllers
        
        mainCoordinator.start()
        profileCoordinator.start()
        
        return tabBarController
    }
}
