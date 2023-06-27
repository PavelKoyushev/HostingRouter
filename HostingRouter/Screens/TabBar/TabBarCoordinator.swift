//
//  TabBarCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import UIKit
import SwiftUI
import Combine

final class TabBarCoordinator: ObservableObject {
    
    private let tabBarController = UITabBarController()
    
    private var mainCoordinator: MainCoordinator?
    private let mainNavigationController = UINavigationController()
    
    private var profileCoordinator: ProfileCoordinator?
    private let profileNavigationController = UINavigationController()
    
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    private let badgeCount = CurrentValueSubject<Int, Never>(0)
    private let selectedTab = PassthroughSubject<Int, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(toRootSwitcher: PassthroughSubject<Flow, Never>) {
        self.toRootSwitcher = toRootSwitcher
        
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
    
    deinit {
        print("\(self) deinited")
    }
    
    func start() -> UITabBarController {
        
        mainCoordinator = MainCoordinator(presenter: mainNavigationController,
                                          badgeCount: badgeCount,
                                          selectedTab: selectedTab)
        
        profileCoordinator = ProfileCoordinator(presenter: profileNavigationController,
                                                toRootSwitcher: toRootSwitcher)
        
        
        mainNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Main", comment: ""),
                                                           image: UIImage(systemName: "house"),
                                                           tag: 0)
        
        profileNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Profile", comment: ""),
                                                              image: UIImage(systemName: "person"),
                                                              tag: 1)
        
        let controllers = [mainNavigationController, profileNavigationController]
        tabBarController.setViewControllers(controllers, animated: false)
        
        mainCoordinator?.start()
        profileCoordinator?.start()
        
        return tabBarController
    }
}
