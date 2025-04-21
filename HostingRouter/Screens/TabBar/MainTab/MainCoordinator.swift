//
//  MainCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 27.06.2023.
//

import SwiftUI
import Combine

final class MainCoordinator: CoordinatorBaseProtocol {
    
    weak var navigationController: UINavigationController?
    
    private let badgeCount: CurrentValueSubject<Int, Never>
    private let selectedTab: PassthroughSubject<Int, Never>
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController?,
         badgeCount: CurrentValueSubject<Int, Never>,
         selectedTab: PassthroughSubject<Int, Never>) {
        
        self.navigationController = navigationController
        self.badgeCount = badgeCount
        self.selectedTab = selectedTab
        
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

extension MainCoordinator {
    
    func start() {
        let viewModel = MainViewModel(badgeCount: badgeCount,
                                      selectedTab: selectedTab)
        let view = MainView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "Main"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.viewControllers = [controller]
    }
}
