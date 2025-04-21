//
//  HistoryDetailViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import Combine

final class HistoryDetailViewModel: ObservableObject {
    
    //MARK: - Services
    var router: HistoryRouter
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    init(router: HistoryRouter) {
        
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        bind()
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension HistoryDetailViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router.toRoot()
            }
            .store(in: &cancellable)
    }
}

extension HistoryDetailViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
