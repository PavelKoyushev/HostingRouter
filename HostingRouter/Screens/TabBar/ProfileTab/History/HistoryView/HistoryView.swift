//
//  HistoryView.swift
//  HostingRouter
//
//  Created by Pavel Koyushev on 25.06.2023.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        content
            .toolbar(content: toolbarContent)
            .padding()
    }
}

private extension HistoryView {
    
    var content: some View {
        VStack {
            Color.green
                .frame(height: 100)
                .cornerRadius(20)
                .onTapGesture {
                    viewModel.input.tap.send()
                }
            Spacer()
        }
    }
}

private extension HistoryView {
    
    @ToolbarContentBuilder func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing, content: trailingItem)
    }
    
    func trailingItem() -> some View {
        Button(action: {}) {
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundColor(.red)
        }
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView(viewModel: HistoryViewModel())
//    }
//}
