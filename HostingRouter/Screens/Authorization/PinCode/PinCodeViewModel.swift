//
//  PinCodeViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import Combine

final class PinCodeViewModel: ObservableObject {
    
    //MARK: - Services
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    private let toRootSwitcher: PassthroughSubject<Flow, Never>
    
    init(toRootSwitcher: PassthroughSubject<Flow, Never>) {
        
        self.toRootSwitcher = toRootSwitcher
        self.input = Input()
        self.output = Output()
        
        bind()
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension PinCodeViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.toRootSwitcher.send(.tabbar)
            }
            .store(in: &cancellable)
    }
}

extension PinCodeViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
