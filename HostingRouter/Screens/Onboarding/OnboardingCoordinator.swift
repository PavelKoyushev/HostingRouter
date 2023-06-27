//
//  OnboardingCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import UIKit
import SwiftUI
import Combine

final class OnboardingCoordinator {
    
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    
    init(toRootSwitcher: PassthroughSubject<Flow, Never>) {
        self.toRootSwitcher = toRootSwitcher
    }
    
    deinit {
        print("\(self) deinited")
    }
    
    func start() -> UINavigationController {
        let viewModel = OnboardingViewModel(toRootSwitcher: toRootSwitcher)
        let view = OnboardingView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
}
