//
//  PhoneView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 23.06.2023.
//

import SwiftUI

struct PhoneView: View {
    
    @StateObject var viewModel: PhoneViewModel
    
    var body: some View {
        VStack {
            Text("Hello, PhoneView!")
            
            Button(action: {
                viewModel.input.tap.send()
            }) {
                Capsule()
                    .fill(.blue)
                    .frame(width: 150, height: 50)
                    .overlay {
                        Text("to pincode")
                            .foregroundColor(.white)
                    }
            }
        }
    }
}

//struct PhoneView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhoneView(viewModel: PhoneViewModel(router: <#AuthRouter?#>))
//    }
//}
