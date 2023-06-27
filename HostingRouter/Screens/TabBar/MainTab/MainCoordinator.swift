//
//  MainCoordinator.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 27.06.2023.
//

import SwiftUI
import Combine

final class MainCoordinator {
    
    weak var presenter: UINavigationController?
    
    private let badgeCount: CurrentValueSubject<Int, Never>
    private let selectedTab: PassthroughSubject<Int, Never>
    
    init(presenter: UINavigationController?,
         badgeCount: CurrentValueSubject<Int, Never>,
         selectedTab: PassthroughSubject<Int, Never>) {
        
        self.presenter = presenter
        self.badgeCount = badgeCount
        self.selectedTab = selectedTab
    }
    
    deinit {
        print("\(self) deinited")
    }
    
    func start() {
        let viewModel = MainViewModel(badgeCount: badgeCount,
                                      selectedTab: selectedTab)
        let view = MainView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        controller.title = "Main"
        
        presenter?.navigationBar.prefersLargeTitles = true
        self.presenter?.setViewControllers([controller], animated: true)
    }
}
