//
//  ProfileViewModel.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import Combine

final class ProfileViewModel: ObservableObject {
    
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
    }
    
    deinit {
        print("\(self) deinited")
    }
}

private extension ProfileViewModel {
    
    func bind() {
        
        input.tap
            .sink { [weak self] in
                self?.router?.toAuth()
            }
            .store(in: &cancellable)
        
        input.notyTap
            .sink { [weak self] in
                self?.router?.pushNotifications()
            }
            .store(in: &cancellable)
        
        input.tapToScreen
            .sink { [weak self] in
                self?.router?.toHistory()
            }
            .store(in: &cancellable)
        
        input.presentModal
            .sink { [weak self] in
                self?.router?.modalView()
            }
            .store(in: &cancellable)
        
        input.presentPopUp
            .sink { [weak self] in
                self?.router?.presentPopUp()
            }
            .store(in: &cancellable)
    }
}

extension ProfileViewModel {
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let tap = PassthroughSubject<Void, Never>()
        
        let notyTap = PassthroughSubject<Void, Never>()
        let tapToScreen = PassthroughSubject<Void, Never>()
        
        let presentModal = PassthroughSubject<Void, Never>()
        let presentPopUp = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
}
