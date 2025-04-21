//
//  ModalFirstView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import SwiftUI

struct ModalFirstView: View {
    
    @StateObject var viewModel: ModalFirstViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Button("push second") {
                    viewModel.input.onPushSecondTap.send()
                }
                
                Button("close") {
                    viewModel.input.onCloseTap.send()
                }
            }
            .padding()
        }
    }
}
