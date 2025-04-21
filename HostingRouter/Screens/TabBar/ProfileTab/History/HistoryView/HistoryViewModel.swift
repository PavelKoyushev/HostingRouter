//
//  HistoryViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import Combine

final class HistoryViewModel: ObservableObject {
    
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
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension HistoryViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router.pushToDetail()
            }
            .store(in: &cancellable)
    }
}

extension HistoryViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
