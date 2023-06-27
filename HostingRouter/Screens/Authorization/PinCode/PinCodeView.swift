//
//  PinCodeView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI

struct PinCodeView: View {
    
    @StateObject var viewModel: PinCodeViewModel
    
    var body: some View {
        VStack {
            Text("Hello, PinCodeView!")
            
            Button(action: {
                viewModel.input.tap.send()
            }) {
                Capsule()
                    .fill(.blue)
                    .frame(width: 150, height: 50)
                    .overlay {
                        Text("to tabbar")
                            .foregroundColor(.white)
                    }
            }
        }
    }
}

//struct PinCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PinCodeView(viewModel: PinCodeViewModel())
//    }
//}
