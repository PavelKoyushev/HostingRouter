//
//  PhoneViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import Combine

final class PhoneViewModel: ObservableObject {
    
    //MARK: - Services
    
    weak var router: AuthRouter?
    
    //MARK: - Input/Output
    let input: Input
    @Published var output: Output
    
    //MARK: - Variables
    private var cancellable = Set<AnyCancellable>()
    
    init(router: AuthRouter?) {
        
        
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        Bind()
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension PhoneViewModel {
    
    func Bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router?.pushPinCode()
            }
            .store(in: &cancellable)
    }
}

extension PhoneViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
