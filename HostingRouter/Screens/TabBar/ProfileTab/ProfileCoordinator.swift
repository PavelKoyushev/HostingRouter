//
//  ProfileCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import SwiftUI
import Combine

final class ProfileCoordinator: CoordinatorBaseProtocol {
    
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

extension ProfileCoordinator {
    
    func start() {
        let viewModel = ProfileViewModel(router: self)
        let view = ProfileView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "Profile"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.viewControllers = [controller]
    }
}

extension ProfileCoordinator {
    
    func removeChild(_ coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll { $0 === coordinator }
        print("Child Coordinator deleted: \(type(of: coordinator))")
    }
}

extension ProfileCoordinator: ProfileRouter {
    
    func toAuth() {
        toRootSwitcher.send(.auth)
    }
    
    func toHistory() {
        let coordinator = HistoryCoordinator(navigationController: navigationController)
        coordinator.start()
    }
    
    func pushNotifications() {
        let viewModel = NotificationsViewModel()
        let view = NotificationsView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        controller.hidesBottomBarWhenPushed = true
        controller.navigationItem.largeTitleDisplayMode = .never
        controller.title = "Notifications"
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func modalView() {
        let viewModel = ModalViewModel(router: self)
        let view = ModalView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "ModalView"
        
        let navController = UINavigationController(rootViewController: controller)
        navController.sheetPresentationController?.detents = [.medium(), .large()]
        
        navigationController?.present(navController, animated: true)
    }
    
    func presentPopUp() {
        let viewModel = PopUpViewModel(router: self)
        let view = UIHostingController(rootView: PopUpView(viewModel: viewModel))
        view.view.backgroundColor = .clear
        
        let navController = UINavigationController(rootViewController: view)
        
        if #available(iOS 16.0, *) {
            navController.sheetPresentationController?.detents = [.custom(resolver: { _ in
                350 + UIScreen.bottomSafeArea
            })]
        } else {
            navController.modalPresentationStyle = .overCurrentContext
        }
        
        navigationController?.present(navController, animated: true)
    }
    
    func presentModalCoordinator() {
        let modalCoordinator = ModalCoordinator(parent: self)
        let navController = modalCoordinator.start()
        
        childCoordinators.append(modalCoordinator)
        
        navigationController?.present(navController, animated: true)
    }
    
    func dismissModal() {
        navigationController?.dismiss(animated: true)
    }
}
