//
//  HistoryCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import Foundation
import UIKit
import SwiftUI

protocol HistoryRouter: AnyObject {
    
    func pushToDetail()
    func toRoot()
}

final class HistoryCoordinator {
    
    weak var presenter: UINavigationController?
    
    init(presenter: UINavigationController?) {
        self.presenter = presenter
    }
    
    deinit {
        print("\(self) deinited")
    }
    
    func start() {
        let viewModel = HistoryViewModel(router: self)
        let view = HistoryView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "History"
        
        self.presenter?.pushViewController(controller, animated: true)
    }
}

extension HistoryCoordinator: HistoryRouter {
    
    func pushToDetail() {
        let viewModel = HistoryDetailViewModel(router: self)
        let view = HistoryDetailView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        self.presenter?.pushViewController(controller, animated: true)
    }
    
    func toRoot() {
        self.presenter?.popToRootViewController(animated: true)
    }
}
