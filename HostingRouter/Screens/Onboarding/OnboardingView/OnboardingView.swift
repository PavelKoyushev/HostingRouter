//
//  OnboardingView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("OnboardingView")
            
            Button(action: {
                viewModel.input.tap.send()
            }) {
                Capsule()
                    .fill(.blue)
                    .frame(width: 150, height: 50)
                    .overlay {
                        Text("Start")
                            .foregroundColor(.white)
                    }
            }
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView(viewModel: OnboardingViewModel(toRootSwitcher: PassthroughSubject<Void, Never>()))
//    }
//}
