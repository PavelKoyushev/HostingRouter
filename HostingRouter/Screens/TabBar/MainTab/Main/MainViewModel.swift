//
//  MainViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import Combine

final class MainViewModel: ObservableObject {
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    private let badgeCount: CurrentValueSubject<Int, Never>
    private let selectedTab: PassthroughSubject<Int, Never>
    
    init(badgeCount: CurrentValueSubject<Int, Never>,
         selectedTab: PassthroughSubject<Int, Never>) {
        
        self.badgeCount = badgeCount
        self.selectedTab = selectedTab
        
        self.input = Input()
        self.output = Output()
        
        bind()
        print("\(self) inited")
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension MainViewModel {
    
    func bind() {
        
        input.buttonTap
            .sink { [weak self] in
                self?.badgeCount.send((self?.badgeCount.value ?? 0) + 1)
            }
            .store(in: &cancellable)
        
        input.switchTab
            .sink { [weak self] in
                self?.selectedTab.send(1)
            }
            .store(in: &cancellable)
    }
}

extension MainViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let buttonTap = PassthroughSubject<Void, Never>()
        let switchTab = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
