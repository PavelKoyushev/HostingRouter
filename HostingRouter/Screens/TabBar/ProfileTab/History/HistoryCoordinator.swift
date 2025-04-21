//
//  HistoryCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import SwiftUI

final class HistoryCoordinator: CoordinatorProtocol {
    
    weak var navigationController: UINavigationController?
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

extension HistoryCoordinator {
    
    func start() {
        let viewModel = HistoryViewModel(router: self)
        let view = HistoryView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "History"
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HistoryCoordinator: HistoryRouter {
    
    func pushToDetail() {
        let viewModel = HistoryDetailViewModel(router: self)
        let view = HistoryDetailView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func toRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
