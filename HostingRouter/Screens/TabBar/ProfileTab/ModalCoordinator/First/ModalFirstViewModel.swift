//
//  ModalFirstViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import Foundation
import Combine

final class ModalFirstViewModel: ObservableObject {
    
    //MARK: - Services
    var router: ModalCoordinatorRouter
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    init(router: ModalCoordinatorRouter) {
        
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension ModalFirstViewModel {
    
    func bind() {
        
        input.onPushSecondTap
            .sink { [weak self] in
                self?.router.pushSecond()
            }
            .store(in: &cancellable)
        
        input.onCloseTap
            .sink { [weak self] in
                self?.router.dismiss()
            }
            .store(in: &cancellable)
    }
}

extension ModalFirstViewModel {
    
    struct Input {
        let onPushSecondTap = PassthroughSubject<Void, Never>()
        let onCloseTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
