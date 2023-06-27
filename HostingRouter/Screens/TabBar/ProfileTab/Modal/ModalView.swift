//
//  ModalView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 24.06.2023.
//

import SwiftUI

struct ModalView: View {
    
    @StateObject var viewModel: ModalViewModel
    
    var body: some View {
        Text("Hello, World!")
            .background(Color.white)
            .onTapGesture {
                viewModel.input.tap.send()
            }
    }
}

//struct ModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView(viewModel: ModalViewModel())
//    }
//}
