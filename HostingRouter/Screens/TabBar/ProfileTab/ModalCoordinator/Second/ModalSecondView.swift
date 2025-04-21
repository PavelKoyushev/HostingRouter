//
//  ModalSecondView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 13.04.2025.
//

import SwiftUI

struct ModalSecondView: View {
    
    @StateObject var viewModel: ModalSecondViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                
                Button("close") {
                    viewModel.input.onCloseTap.send()
                }
            }
        }
    }
}
