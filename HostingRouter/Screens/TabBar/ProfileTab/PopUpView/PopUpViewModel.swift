//
//  PopUpViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 26.06.2023.
//

import Combine

final class PopUpViewModel: ObservableObject {
    
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
        
        bind()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension PopUpViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router?.dismissModal()
            }
            .store(in: &cancellable)
    }
}

extension PopUpViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}

