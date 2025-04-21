//
//  AppCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI
import Combine

final class AppCoordinator: CoordinatorProtocol {
    
    private let window: UIWindow
    
    private let toRootSwitcher = PassthroughSubject<Flow, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(window: UIWindow) {
        
        self.window = window
        
        bind()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

extension AppCoordinator {
    
    func start() {
        startOnboarding()
    }
}

private extension AppCoordinator {
    
    func bind() {
        
        toRootSwitcher
            .sink { [weak self] in
                switch $0 {
                case .auth:
                    self?.childCoordinators.removeAll()
                    self?.startAuth()
                case .tabbar:
                    self?.childCoordinators.removeAll()
                    self?.startTabBar()
                }
            }
            .store(in: &cancellable)
    }
}

private extension AppCoordinator {
    
    func startOnboarding() {
        let navigationController = UINavigationController()
        let coordinator = OnboardingCoordinator(navigationController: navigationController,
                                                toRootSwitcher: toRootSwitcher)
        
        childCoordinators.append(coordinator)
        coordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func startAuth() {
        let navigationController = UINavigationController()
        let coordinator = AuthCoordinator(navigationController: navigationController,
                                          toRootSwitcher: toRootSwitcher)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func startTabBar() {
        let coordinator = TabBarCoordinator(toRootSwitcher: toRootSwitcher)
        childCoordinators.append(coordinator)
        
        window.rootViewController = coordinator.start()
        window.makeKeyAndVisible()
    }
}
