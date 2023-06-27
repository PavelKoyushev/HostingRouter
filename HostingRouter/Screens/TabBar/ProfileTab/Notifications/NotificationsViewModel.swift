//
//  NotificationsViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import Combine

final class NotificationsViewModel: ObservableObject {
    
    //MARK: - Services
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
        self.input = Input()
        self.output = Output()
        
        Bind()
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension NotificationsViewModel {
    
    func Bind() {
        
    }
}

extension NotificationsViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
