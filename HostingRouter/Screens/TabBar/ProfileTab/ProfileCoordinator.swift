//
//  ProfileCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import SwiftUI
import Combine

protocol ProfileRouter: AnyObject {
    
    func toAuth()
    func toHistory()
    func pushNotifications()
    func modalView()
    func presentPopUp()
    
    func dismissModal()
}

final class ProfileCoordinator {
    
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
        let viewModel = ProfileViewModel(router: self)
        let view = ProfileView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "Profile"
        
        presenter?.navigationBar.prefersLargeTitles = true
        self.presenter?.setViewControllers([controller], animated: true)
    }
}

extension ProfileCoordinator: ProfileRouter {
    
    func toAuth() {
        self.toRootSwitcher.send(.auth)
    }
    
    func toHistory() {
        let coordinator = HistoryCoordinator(presenter: presenter)
        coordinator.start()
    }
    
    func pushNotifications() {
        let viewModel = NotificationsViewModel()
        let view = NotificationsView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        controller.hidesBottomBarWhenPushed = true
        controller.navigationItem.largeTitleDisplayMode = .never
        controller.title = "Notifications"
        
        self.presenter?.pushViewController(controller, animated: true)
    }
    
    func modalView() {
        let viewModel = ModalViewModel(router: self)
        let view = ModalView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        let navController = UINavigationController(rootViewController: controller)
        navController.sheetPresentationController?.detents = [.medium(), .large()]
        
        self.presenter?.present(navController, animated: true)
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
        
        self.presenter?.present(navController, animated: true)
    }
    
    func dismissModal() {
        self.presenter?.dismiss(animated: true)
    }
}
