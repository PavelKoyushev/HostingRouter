//
//  ModalViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import Combine

final class ModalViewModel: ObservableObject {
    
    //MARK: - Services
    private var router: ProfileRouter?
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    init(router: ProfileRouter?) {
        
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        Bind()
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension ModalViewModel {
    
    func Bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router?.dismissModal()
            }
            .store(in: &cancellable)
    }
}

extension ModalViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
