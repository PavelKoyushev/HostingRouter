//
//  OnboardingViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import Combine

final class OnboardingViewModel: ObservableObject {
    
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
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension OnboardingViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.toRootSwitcher.send(.auth)
            }
            .store(in: &cancellable)
    }
}

extension OnboardingViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
