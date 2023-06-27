//
//  AuthCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI
import Combine

protocol AuthRouter: AnyObject {
    
    func pushPinCode()
}

final class AuthCoordinator {
    
    weak var presenter: UINavigationController?
    
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    
    init(presenter: UINavigationController?,
         toRootSwitcher: PassthroughSubject<Flow, Never>) {
        self.presenter = presenter
        self.toRootSwitcher = toRootSwitcher
    }
    
    deinit {
        print("\(self) deinited")
    }
    
    func start() {
        let viewModel = PhoneViewModel(router: self)
        let view = PhoneView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        presenter?.viewControllers = [controller]
    }
}

extension AuthCoordinator: AuthRouter {
    
    func pushPinCode() {
        let viewModel = PinCodeViewModel(toRootSwitcher: toRootSwitcher)
        let view = PinCodeView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        presenter?.pushViewController(controller, animated: true)
    }
}
