//
//  ModalSecondViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import Foundation
import Combine

final class ModalSecondViewModel: ObservableObject {
    
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

private extension ModalSecondViewModel {
    
    func bind() {
        
        input.onCloseTap
            .sink { [weak self] in
                self?.router.dismiss()
            }
            .store(in: &cancellable)
    }
}

extension ModalSecondViewModel {
    
    struct Input {
        let onCloseTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
