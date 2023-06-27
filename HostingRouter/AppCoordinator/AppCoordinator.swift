//
//  AppCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI
import Combine

enum Flow {
    
    case auth
    case tabbar
}

final class AppCoordinator {
    
    private unowned var sceneDelegate: SceneDelegate
    
    private var onbCoordinator: OnboardingCoordinator?
    private var authCoordinator: AuthCoordinator?
    private var taBBarCoordinator: TabBarCoordinator?
    
    private let toRootSwitcher = PassthroughSubject<Flow, Never>()
    
    private var cancellable = Set<AnyCancellable>()
    
    private var navigationController: UINavigationController?
    
    init(sceneDelegate: SceneDelegate) {
        
        self.sceneDelegate = sceneDelegate
        self.navigationController = UINavigationController()
        
        toRootSwitcher
            .sink { [weak self] in
                switch $0 {
                case .auth:
                    self?.startAuth()
                    self?.onbCoordinator = nil
                    self?.taBBarCoordinator = nil
                case .tabbar:
                    self?.startTabBar()
                    self?.navigationController = nil
                    self?.authCoordinator = nil
                }
            }
            .store(in: &cancellable)
        
        startOnboarding()
    }
    
    func startOnboarding() {
        onbCoordinator = OnboardingCoordinator(toRootSwitcher: toRootSwitcher)
        sceneDelegate.window!.rootViewController = onbCoordinator?.start()
    }
    
    func startTabBar() {
        taBBarCoordinator = TabBarCoordinator(toRootSwitcher: toRootSwitcher)
        sceneDelegate.window!.rootViewController = taBBarCoordinator?.start()
    }
    
    func startAuth() {
        navigationController = UINavigationController()
        sceneDelegate.window!.rootViewController = navigationController
        
        authCoordinator = AuthCoordinator(presenter: navigationController,
                                          toRootSwitcher: toRootSwitcher)
        authCoordinator?.start()
    }
}
