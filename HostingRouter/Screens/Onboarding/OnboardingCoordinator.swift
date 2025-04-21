//
//  OnboardingCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI
import Combine

final class OnboardingCoordinator: CoordinatorBaseProtocol {
    
    weak var navigationController: UINavigationController?
    
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController?,
         toRootSwitcher: PassthroughSubject<Flow, Never>) {
        
        self.navigationController = navigationController
        self.toRootSwitcher = toRootSwitcher
        
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

extension OnboardingCoordinator {
    
    func start() {
        let viewModel = OnboardingViewModel(toRootSwitcher: toRootSwitcher)
        let view = OnboardingView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        navigationController?.viewControllers = [controller]
    }
}
