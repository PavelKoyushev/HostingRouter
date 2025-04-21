//
//  CoordinatorProtocol.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 15.04.2025.
//

import UIKit.UINavigationController

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
}

protocol CoordinatorBaseProtocol: CoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol CoordinatorModalProtocol: CoordinatorProtocol {
    func start() -> UIViewController
}
