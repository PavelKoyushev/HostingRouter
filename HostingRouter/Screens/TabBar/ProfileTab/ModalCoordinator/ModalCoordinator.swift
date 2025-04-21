//
//  ModalCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import SwiftUI
import Combine

final class ModalCoordinator: NSObject, CoordinatorModalProtocol {
    
    weak var navigationController: UINavigationController?
    weak var parent: ProfileCoordinator?
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController? = nil,
         parent: ProfileCoordinator? = nil) {
        
        self.navigationController = navigationController
        self.parent = parent
        
        super.init()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

extension ModalCoordinator {
    
    func start() -> UIViewController {
        let viewModel = ModalFirstViewModel(router: self)
        let first = ModalFirstView(viewModel: viewModel)
        
        let controller = CustomHostingController(rootView: first)
        let navigationController = UINavigationController(rootViewController: controller)
        
        navigationController.modalPresentationStyle = .formSheet
        
        navigationController.presentationController?.delegate = self
        
        self.navigationController = navigationController
        
        return navigationController
    }
}

extension ModalCoordinator: ModalCoordinatorRouter {
    
    func pushSecond() {
        let viewModel = ModalSecondViewModel(router: self)
        let view = ModalSecondView(viewModel: viewModel)
        
        let controller = CustomHostingController(rootView: view)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true) { [weak self] in
            self?.cleanup()
        }
    }
}

extension ModalCoordinator: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanup()
        }
    }
}

private extension ModalCoordinator {
    
    func cleanup() {
        parent?.removeChild(self)
    }
}
