//
//  AuthCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI
import Combine

final class AuthCoordinator: CoordinatorBaseProtocol {
    
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

extension AuthCoordinator {
    
    func start() {
        let viewModel = PhoneViewModel(router: self)
        let view = PhoneView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        navigationController?.viewControllers = [controller]
    }
}

extension AuthCoordinator: AuthRouter {
    
    func pushPinCode() {
        let viewModel = PinCodeViewModel(toRootSwitcher: toRootSwitcher)
        let view = PinCodeView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
