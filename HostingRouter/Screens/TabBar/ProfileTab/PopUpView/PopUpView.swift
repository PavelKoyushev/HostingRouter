//
//  PopUpView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 26.06.2023.
//

import SwiftUI

struct PopUpView: View {
    
    @StateObject var viewModel: PopUpViewModel
    
    var body: some View {
        content
            .padding(.horizontal)
            .padding(.bottom, 50 + UIScreen.bottomSafeArea)
    }
}

private extension PopUpView {
    
    var content: some View {
        VStack {
            Text("Hello, PopUpView!")
                .onTapGesture {
                    viewModel.input.tap.send()
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(viewModel: PopUpViewModel(router: nil))
    }
}
